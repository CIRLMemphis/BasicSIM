% see section [TODO] in the documentation
function [im, jm, Nm] = Pattern3W3D(X, Y, Z, omegaXY, omegaZ, dXY, dZ, phiDeg, offsDeg, thetaDeg, phizDeg)
[yy, xx, zz] = meshgrid(0 : 1 : X-1, 0 : 1 : Y-1, 0 : 1 : Z-1);
Nm    = 3;            % 3W 3D has 3 components
phi   = pi*phiDeg/180;
offs  = pi*offsDeg/180;
theta = pi*thetaDeg/180;
phiz  = pi*phizDeg/180;
Nphi  = length(phi);
Nthe  = length(theta);
im    = ones(X,Y,Z,Nthe,Nphi,Nm);
jm    = ones(X,Y,Z,Nthe,Nphi,Nm);

for l = 1:Nthe
    fxx   = sin(theta(l))*xx*dXY;
    fyy   = cos(theta(l))*yy*dXY;
    fzz   = zz*dZ;
    for k = 1:Nphi
        im(:,:,:,l,k,3) = cos( 2*pi*omegaZ(l)*fzz + phiz);
        jm(:,:,:,l,k,2) = 2/3*cos( 2*pi*omegaXY(l)*(fyy + fxx) + phi(k)    + offs(l));
        jm(:,:,:,l,k,3) = 4/3*cos((2*pi*omegaXY(l)*(fyy + fxx) + phi(k))/2 + offs(l));
    end
end