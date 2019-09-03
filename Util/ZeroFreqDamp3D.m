function ret = ZeroFreqDamp3D(in3D,X,Y,Z,dXY,dZ,A,sigma)
[yy, xx, zz] = meshgrid(1:1:Y, 1:1:X, 1:1:Z);
radius = sqrt(((xx - (1+X/2))/X/dXY).^2 + ((yy - (1+Y/2))/X/dXY).^2 + ((zz - (1+Z/2))/Z/dZ).^2);
damp   = 1 - A*exp(-radius./sigma^2);
ret    = in3D.*damp;
end