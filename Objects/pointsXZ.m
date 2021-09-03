function f = pointsXZ( XY, Z, dXY, dZ, RadiusZ, Distance, DistanceZTop, DistanceZBot )
dSIMz     = round(2*RadiusZ /dZ);

aSIMz     = bead(dZ, dZ, dSIMz , dSIMz,  RadiusZ,  RadiusZ);
Fil_size  = 4+1;
sd        = 0.7;
aSIMz     = smooth3(aSIMz, 'gaussian',Fil_size,sd);

f        = zeros(XY, XY, Z);
%% two points with adjustable distance
dis      = round(Distance /dXY);       % in pixels
disZTop  = round(DistanceZTop/dZ);     % in pixels
disZBot  = round(DistanceZBot/dZ);     % in pixels

%% ON XZ PLANE
% along z < 0 axis
% SIM 1
xc = round(XY/2-dis/2);
yc = round(XY/2);  
zc = round(XY/2-disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 2
xc = round(XY/2-dis/2);
yc = round(XY/2);  
zc = round(XY/2-disZTop*2);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 3
xc = round(XY/2-dis*3/2);
yc = round(XY/2);  
zc = round(XY/2-disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% along z < 0 on the other side
% SIM 1
xc = round(XY/2+dis/2);
yc = round(XY/2);  
zc = round(XY/2-disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 2
xc = round(XY/2+dis/2);
yc = round(XY/2);  
zc = round(XY/2-disZTop*2);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 3
xc = round(XY/2+dis*3/2);
yc = round(XY/2);  
zc = round(XY/2-disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;



% along z > 0 axis
% SIM 1
xc = round(XY/2-dis/2);
yc = round(XY/2);  
zc = round(XY/2+disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 2
xc = round(XY/2-dis/2);
yc = round(XY/2);  
zc = round(XY/2+disZBot+disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 3
xc = round(XY/2-dis*3/2);
yc = round(XY/2);  
zc = round(XY/2+disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% along z > 0 on the other side
% SIM 1
xc = round(XY/2+dis/2);
yc = round(XY/2);  
zc = round(XY/2+disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 2
xc = round(XY/2+dis/2);
yc = round(XY/2);  
zc = round(XY/2+disZBot+disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 3
xc = round(XY/2+dis*3/2);
yc = round(XY/2);  
zc = round(XY/2+disZTop);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;