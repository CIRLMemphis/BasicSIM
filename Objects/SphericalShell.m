function h = SphericalShell (X, Y, Z, dXY, Radius, Thickness)
radius1 = (Radius-Thickness/1.5)./dXY;
radius2 = (Radius)./dXY;
center = [1+Y/2 1+X/2 1+Z/2];

power = 5;

h = zeros(Y, X, Z);
for z = 1:Z
    zc = z - center(3);
    for y = 1:Y
        yc = y - center(1);
        for x = 1:X
            xc = x - center(2);
            r = sqrt( xc*xc + yc*yc + zc*zc ); % so that the sphere is shifted to the center
            if r <= radius1
                h(y,x,z) = r.^power;
            elseif r <= radius2 && r >= radius1
                h(y,x,z) = radius1.^power;
            else
                rt = r - radius2;
                h(y,x,z) = radius1.^power.*exp(-rt/5);
            end
        end
    end
end

h = h./max(h(:));
Fil_size = 4+1; sd = 4; h = smooth3(h, 'gaussian',Fil_size,sd);
h = h./max(h(:));