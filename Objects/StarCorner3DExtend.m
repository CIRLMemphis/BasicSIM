function ret = StarCorner3DExtend(newX, newY, newZ, sigma, Z)
if (nargin < 5)
    Z = 10;
end
obj = StarLike3D(sigma, Z);
obj = obj(75:124, 75:124, :);
[X, Y, Z] = size(obj);
extX = (newX-X)/2;
extY = (newY-Y)/2;
extZ = (newZ-Z)/2;
ret = zeros(X+2*extX, Y+2*extY, Z+2*extZ);
ret(extX+1:extX+X, extY+1:extY+Y, extZ+1:extZ+Z) = obj;
end