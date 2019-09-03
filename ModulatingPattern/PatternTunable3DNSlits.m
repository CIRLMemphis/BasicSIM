% see section [TODO] in the documentation
function [im, jm, Nm] = PatternTunable3DNSlits(X, Y, Z, omegaXY, omegaZ, dXY, dZ, phiDeg, offsDeg, thetaDeg, phizDeg, Nslits)
[yy, xx, zz] = meshgrid(0 : 1 : X-1, 0 : 1 : Y-1, 0 : 1 : Z-1);
Nm    = 2;            % 3-slit tunable SIM has 2 pattern components
phi   = pi*phiDeg/180;
offs  = pi*offsDeg/180;
theta = pi*thetaDeg/180;
phiz  = pi*phizDeg/180;
Nphi  = length(phi);
Nthe  = length(theta);
im    = ones(X,Y,Z,Nthe,Nphi,Nm);
jm    = ones(X,Y,Z,Nthe,Nphi,Nm);

for l = 1:Nthe
    xy = 2*pi*omegaXY(l)*(cos(theta(l))*yy + sin(theta(l))*xx)*dXY;
    im(:,:,:,l,:,2) = repmat(Visibility(zz*dZ, omegaZ(l), Nslits, phiz), ...
                             [1 1 1 Nphi]);
    for k = 1:Nphi
        jm(:,:,:,l,k,2) = xy + phi(k) + offs(l);
    end
    jm(:,:,:,l,:,2) = cos(jm(:,:,:,l,:,2));
end