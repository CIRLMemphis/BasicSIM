function ImageXYXZ(var, zBF, yBF, lThe, kPhi)
[Y, X, Z] = size(var);
if (nargin < 2)
    zBF = 1 + Z/2;
end
if (nargin < 3)
    yBF = 1 + Y/2;
end
if (nargin < 4)
    lThe = 1;
end
if (nargin < 5)
    kPhi = 1;
end
figure;
imagesc(var(:,:,zBF,lThe,kPhi)); axis square; colormap gray; colorbar;
xlabel('x'); ylabel('y');
figure;
imagesc(squeeze(var(yBF,:,:,lThe,kPhi))'); axis square; colormap gray;
xlabel('x'); ylabel('z');
end