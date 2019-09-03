function ret = StarLike3DExtend(newX, newY, newZ)
obj = StarLike3D();
[X, Y, Z] = size(obj);
extX = (newX-X)/2;
extY = (newY-Y)/2;
extZ = (newZ-Z)/2;
ret = zeros(X+2*extX, Y+2*extY, Z+2*extZ);
ret(extX+1:extX+X, extY+1:extY+Y, extZ+1:extZ+Z) = obj;
%ret = imgaussfilt3(ret, 2);
end