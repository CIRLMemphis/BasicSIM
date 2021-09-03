function f = pointsXYZ( XY, Z, dXY, dZ, Radius, Distance, DistanceZ )
d = round(2*Radius/dXY);
Thickness = Radius;
aTiny     = bead(dXY, dZ, d, d, Radius, Thickness);
SIMRadXY  = 0.07;
SIMRadZ   = 0.12;
dSIMxy    = round(2*SIMRadXY/dXY);
dSIMz     = round(2*SIMRadZ /dZ);
aSIMxy    = bead(dXY, dZ, dSIMxy, dSIMxy, SIMRadXY, SIMRadXY);
Fil_size  = 2+1;
sd        = 0.4;
aSIMxy    = smooth3(aSIMxy, 'gaussian',Fil_size,sd);

aSIMz     = bead(dXY, dZ, dSIMz , dSIMz,  SIMRadZ,  SIMRadZ);
Fil_size  = 4+1;
sd        = 0.7;
aSIMz     = smooth3(aSIMz, 'gaussian',Fil_size,sd);

f = zeros(XY, XY, Z);
%% two points with adjustable distance
dis      = round(Distance /dXY);       % in pixels
disZ     = round(DistanceZ/dZ);        % in pixels
disSIMxy = dis + round(dis/2);
diagDist = round(disSIMxy/sqrt(2));

%% along x axis
xc = round(XY/2-dis);
yc = round(XY/2);
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

xc = round(XY/2+dis);
yc = round(XY/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

% SIM 1
xc = round(XY/2-dis-disSIMxy);
yc = round(XY/2);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2+dis+disSIMxy);
yc = round(XY/2); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 2
xc = round(XY/2-dis-disSIMxy*2);
yc = round(XY/2);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2+dis+disSIMxy*2);
yc = round(XY/2); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% along y axis
xc = round(XY/2);
yc = round(XY/2-dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

xc = round(XY/2);
yc = round(XY/2+dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

% SIM 1
xc = round(XY/2);
yc = round(XY/2-dis-disSIMxy);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2);
yc = round(XY/2+dis+disSIMxy); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 2
xc = round(XY/2);
yc = round(XY/2-dis-disSIMxy*2);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2);
yc = round(XY/2+dis+disSIMxy*2); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% both x and y
xc = round(XY/2+dis);
yc = round(XY/2+dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

xc = round(XY/2-dis);
yc = round(XY/2+dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

xc = round(XY/2+dis);
yc = round(XY/2-dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

xc = round(XY/2-dis);
yc = round(XY/2-dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = aTiny;

% SIM 1
xc = round(XY/2-dis - diagDist);
yc = round(XY/2-dis - diagDist);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2+dis + diagDist);
yc = round(XY/2+dis + diagDist); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 2
xc = round(XY/2-dis-diagDist*2);
yc = round(XY/2-dis-diagDist*2);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2+dis+diagDist*2);
yc = round(XY/2+dis+diagDist*2); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 3
xc = round(XY/2+dis+diagDist);
yc = round(XY/2-dis-diagDist);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2-dis-diagDist);
yc = round(XY/2+dis+diagDist); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 4
xc = round(XY/2+dis+diagDist*2);
yc = round(XY/2-dis-diagDist*2);  
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

xc = round(XY/2-dis-diagDist*2);
yc = round(XY/2+dis+diagDist*2); 
zc = round(XY/2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;


%% ON XZ PLANE
% along z < 0 axis
% SIM 1
xc = round(XY/2-dis);
yc = round(XY/2);  
zc = round(XY/2-disZ);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 2
xc = round(XY/2-dis);
yc = round(XY/2);  
zc = round(XY/2-disZ*2);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 3
xc = round(XY/2-dis-disZ);
yc = round(XY/2);  
zc = round(XY/2-disZ);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% along z < 0 on the other side
% SIM 1
xc = round(XY/2+dis);
yc = round(XY/2);  
zc = round(XY/2-disZ);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 2
xc = round(XY/2+dis);
yc = round(XY/2);  
zc = round(XY/2-disZ*2);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% SIM 3
xc = round(XY/2+dis+disZ);
yc = round(XY/2);  
zc = round(XY/2-disZ);
f( yc-dSIMz/2+1:yc+dSIMz/2, xc-dSIMz/2+1:xc+dSIMz/2, zc-dSIMz/2+1:zc+dSIMz/2) = aSIMz;

% along z > 0 axis
% SIM 1
xc = round(XY/2-dis);
yc = round(XY/2);  
zc = round(XY/2+disSIMxy);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 2
xc = round(XY/2-dis);
yc = round(XY/2);  
zc = round(XY/2+disSIMxy*2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 3
xc = round(XY/2-dis-disSIMxy);
yc = round(XY/2);  
zc = round(XY/2+disSIMxy);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% along z < 0 axis on the other side
% SIM 1
xc = round(XY/2+dis);
yc = round(XY/2);  
zc = round(XY/2+disSIMxy);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 2
xc = round(XY/2+dis);
yc = round(XY/2);  
zc = round(XY/2+disSIMxy*2);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;

% SIM 3
xc = round(XY/2+dis+disSIMxy);
yc = round(XY/2);  
zc = round(XY/2+disSIMxy);
f( yc-dSIMxy/2+1:yc+dSIMxy/2, xc-dSIMxy/2+1:xc+dSIMxy/2, zc-dSIMxy/2+1:zc+dSIMxy/2) = aSIMxy;