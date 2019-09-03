function ret = StarLike3D(sigma, Z)
starlikeXY = load("XZStarlike.mat", 'obj');
obj = imgaussfilt(starlikeXY.obj, sigma);
obj = obj./max(obj(:));
if (nargin < 2)
    Z = 10;
end
ret = permute(repmat(obj, [1,1,Z]), [2, 1, 3]);
end