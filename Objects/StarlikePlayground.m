X = 256; Y = 256; Z = 256;
obj3D = StarLike3DExtend(X,Y,Z);
objFT = abs(fftshift(fftn(obj3D)));
figure; imagesc(squeeze(obj3D(:,:,Z/2)))
figure; imagesc(squeeze(objFT(:,:,Z/2)))