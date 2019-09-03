function [ h ] = PSFLutz( XY, Z, dXY, dZ, p)
% prepare phase mask
ovs = p.oversampling; osc = p.overrange;
if ~strcmp(p.maskkind, 'none')
    XY = XY * osc * ovs;
    dXY = dXY / ovs;
    p.amplitudepsf = true;
else
    p.amplitudepsf = false;
end

R2 = floor(XY/sqrt(2)+2.5); % radius along the diagonal of a rectangle
r_ = linspace(0, (R2-1)*dXY, R2);
psf = zeros(XY,XY,Z);

if ~p.sa && ~p.amplitudepsf
    z_ = linspace(0, sz*(Z/2-1), Z/2);
    y = wfpsf(r_, z_, p);
    num = 0;
    for zz = 1:Z/2
        zo = zz + Z/2 - 1;
        for yy = 1:XY
            yc = yy - XY/2 - 1;
            ycc = yc * yc;
            for xx = 1:XY
                xc = xx - XY/2 - 1;
                rad = sqrt(xc*xc + ycc );
                irad = floor(rad);
                rad1 = rad - irad;
                rad2 = 1 - rad1;
                psf(xx,yy,zo) = rad2*y(zz,irad+1) + rad1*y(zz,irad+2);
                if zz > 1
                    psf(xx,yy,zo-num) = psf(xx,yy,zo); % mirroring the data
                end
            end
        end
        num = num + 2;
    end
else
    z_ = linspace(-dZ*(Z/2-1), dZ*(Z/2), Z);
    y = wfpsf(r_, z_, p);
    for zz = 1:Z
        for yy = 1:XY
            yc = yy - XY/2 - 1;
            ycc = yc * yc;
            for xx = 1:XY
                xc = xx - XY/2 - 1;
                rad = sqrt(xc*xc + ycc );
                irad = floor(rad);
                rad1 = rad - irad;
                rad2 = 1 - rad1;
                psf(xx,yy,zz) = rad2*y(zz,irad+1) + rad1*y(zz,irad+2);
            end
        end
    end
end

if ~strcmp(p.maskkind, 'none')
    % create slice CTF from complex APSF via DFT
    slicectf=zeros(size(psf));
    for z=1:Z
        slicectf(:,:,z) = fftshift(fft2(fftshift(psf(:,:,z))));
    end
    
    % phase mask creation
    [x, y]=meshgrid(-ovs:2*ovs/(XY-1):ovs);
    phi = p.cartmask(p, x, y);
    
    % create phase shifts
    msk = cos(phi) + 1i*sin(phi);
    
    % mask circular region, clip to zero outside circle (to be discussed)
    cmask = sqrt(x.^2 + y.^2) <= ovs;
    msk = msk .* cmask;
    
    % multiply mask and ifft
    psftmp = zeros(size(psf));
    for z=1:Z
        psftmp(:,:,z) = ifftshift(ifft2(ifftshift(slicectf(:,:,z) .* msk)));
    end
    
    % downsample if ovs > 1
    psftmp = imresize(psftmp,1/ovs);
    
    % cut volume to desired size when osc > 1
    XY = XY / ovs;
    range = ceil((XY-XY/osc+1)/2):(XY-XY/osc)/2+XY/osc;
    psf = abs(psftmp(range, range, :)).^2;
end
%h = psf./max(psf(:));
h = psf./sum(psf(:));