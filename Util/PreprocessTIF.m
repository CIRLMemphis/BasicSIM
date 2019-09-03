close all; clear; clc
img = ReadTIF('C:\Users\cvan\OneDrive - The University of Memphis\CIRLData\FairSimData\OMX_U2OS_Actin_525nm.tif', 3, 5);
[X,Y,Z,Nalp,Nphi] = size(img);
slideNo = 7;
curSlice = img(:,:,slideNo,:,:);
figure;imagesc(curSlice(:,:,1,1,1)); axis square; colorbar

%%
figure;
for i = 1:Nphi
    hold on;plot(img(1+X/2, :, (Z-1)/2, 1, i));
end

figure;
for i = 1:Nalp
    hold on;plot(img(1+X/2, :, (Z-1)/2, i, 1));
end

figure;
for i = 1:Nphi
    hold on;plot(real(FT(img(1+X/2, :, (Z-1)/2, 1, i))));
end
