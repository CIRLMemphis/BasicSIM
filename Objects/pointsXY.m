function f = pointsXY( XY, Z, dXY, dZ, Radius, Distance )
d = round(2*Radius/dXY);
Thickness = Radius;
a = bead(dXY, dZ, d, d, Radius, Thickness);

f = zeros(XY, XY, Z);
%% two points with adjustable distance
dis = Distance/dXY;       % in pixels

xc = round(XY/2-dis/2);
yc = round(XY/2);
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2+dis/2);
yc = round(XY/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2);
yc = round(XY/2-dis/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2);
yc = round(XY/2+dis/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

% xc = round(XY/2);
% yc = round(XY/2);
% zc = round(XY/2-dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2);
% yc = round(XY/2); 
% zc = round(XY/2+dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xc = round(XY/2+dis/2);
yc = round(XY/2+dis/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2-dis/2);
yc = round(XY/2+dis/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2+dis/2);
yc = round(XY/2-dis/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2-dis/2);
yc = round(XY/2-dis/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc = round(XY/2+dis/2);
% yc = round(XY/2); 
% zc = round(XY/2+dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2-dis/2);
% yc = round(XY/2); 
% zc = round(XY/2+dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2+dis/2);
% yc = round(XY/2); 
% zc = round(XY/2-dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2-dis/2);
% yc = round(XY/2); 
% zc = round(XY/2-dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc = round(XY/2);
% yc = round(XY/2+dis/2); 
% zc = round(XY/2+dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2);
% yc = round(XY/2-dis/2); 
% zc = round(XY/2+dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2);
% yc = round(XY/2+dis/2); 
% zc = round(XY/2-dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2);
% yc = round(XY/2-dis/2); 
% zc = round(XY/2-dis/2);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xc = round(XY/2-dis);
yc = round(XY/2);  
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2+dis);
yc = round(XY/2); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2);
yc = round(XY/2-dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

xc = round(XY/2);
yc = round(XY/2+dis); 
zc = round(XY/2);
f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;

% xc = round(XY/2);
% yc = round(XY/2); 
% zc = round(XY/2-dis);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
% 
% xc = round(XY/2);
% yc = round(XY/2); 
% zc = round(XY/2+dis);
% f( yc-d/2+1:yc+d/2, xc-d/2+1:xc+d/2, zc-d/2+1:zc+d/2) = a;
