function ret = StarLike2DExtend(newX, newZ)
starlikeXZ = load("XZStarlike.mat", 'obj');
obj = starlikeXZ.obj;
[X, Z] = size(obj);
extX = (newX-X)/2;
extZ = (newZ-Z)/2;
ret = zeros(X+2*extX, Z+2*extZ);
ret(extX+1:extX+X, extZ+1:extZ+Z) = obj;
end