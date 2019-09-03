% BEAD prepares a 3d hollow bead image
% bead ( ScaleR, ScaleZ, SizeR, SizeZ, Radius, Thickness )
% ScaleR    : Transverse (radial) scaling factor in Microns/pixel ( X,Y scaling )
% ScaleZ    : Axial scaling in Microns/pixel
% SizeR     : Determines the size of X and Y dimensions of the image ( X = Y )
%             SizeR should be EVEN
% SizeZ     : Number of z-stacks
% Radius    : Radius of the bead in Microns
% Thickness : Thickness of the bead walls in Microns
function f = bead ( sxy, sz, xy_, z_ , r_, t_ )
xy_h = xy_/2;
z_h  = z_/2;
f = zeros(xy_, xy_, z_); 
for z = 1:z_            
    zc = sz*(z - z_h);
    for y = 1:xy_          
        yc = sxy*(y - xy_h);
        for x = 1:xy_
            xc = sxy*(x - xy_h);
            r = sqrt(xc*xc + yc*yc + zc*zc ); % so that the sphere is shifted to the center
            if r >= r_ - t_ && r < r_           
                f(y,x,z) = 1;
            end
        end
    end
end