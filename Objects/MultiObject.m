function [ f ] = MultiObject( X, Z, dXY, dZ)

% OneBead
Radius    = 3/2;      % radius of bead in microns
Thickness = 0.4/2;      % shell thickness of bead in microns
f1 = bead(dXY, dZ, X, Z, Radius, Thickness);
Fil_size = 2+1;
sd = 2;
f1 = smooth3(f1, 'gaussian',Fil_size,sd);
f1 = f1./max(f1(:));

% % Multi points
% dis = 0.111/dXY;     % in pixels
% f(1+XY/2          , ceil(1+XY/2-dis),           1+Z/2) = 1;
% %f(1+XY/2          , 1+XY/2          ,           1+Z/2) = 1;
% f(1+XY/2          , ceil(1+XY/2+dis),           1+Z/2) = 1;
% f(ceil(1+XY/2-dis), 1+XY/2          ,           1+Z/2) = 1;
% f(ceil(1+XY/2+dis), 1+XY/2          ,           1+Z/2) = 1;
% f(1+XY/2          , 1+XY/2          , ceil(1+Z/2-dis)) = 1;
% f(1+XY/2          , 1+XY/2          , ceil(1+Z/2+dis)) = 1;
% % 'LightSheet'
% f = zeros(XY, XY, Z);
% f( :,:,1+Z/2) = 1;
% %f( 10:XY-10,10:XY-10,1+Z/2) = 1;

% % 'More than one point without smoothing'
% Radius   = 0.1/2;   % radius of bead in microns
% Distance = 0.15;   % shell thickness of bead in microns
% f = pointsXY(XY, Z, dXY, dZ, Radius, Distance);

% 'More than one point with smoothing'
%r = 50 nm, dis = 111 or 222 nm -->FilSize = 4+1 and sd = 2
Radius   = 0.0750;%( 0.2/dXY - 0)*dXY/2;   % radius of bead in microns
Distance = 2*Radius + 0.200;                  % shell thickness of bead in microns
f2 = pointsXY(X, Z, dXY, dZ, Radius, Distance);
Fil_size = 2+1;
sd = 1;
f2 = smooth3(f2, 'gaussian',Fil_size,sd);
%f2 = 1.04.*f2./max(f2(:));%1.9
f2 = 1*f2./max(f2(:));%1.9

f = f1 + f2;