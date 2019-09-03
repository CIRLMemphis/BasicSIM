function filteredImage = CosineApodizer(image)
% MATLAB function to gennerate Cosine Apodization mask
% filter = CosineApodizer(size_x, size_y, size_z)
% Author : Nurmohammed Patwary ; Date : 02/03/2016
% x = 420 ;  y = 472; Z = 200;

[size_x size_y size_z] = size(image);

x = linspace(-1,1,size_x);
y = linspace(-1,1,size_y);
z = linspace(-1,1,size_z);

[xx yy zz] = meshgrid(x,y,z);

elliptical_axis = (xx).^2+(yy).^2+(zz).^2;
elliptical_axis_mask =  (elliptical_axis > 1) == 0;
elliptical_axis  = elliptical_axis.*elliptical_axis_mask;
% figure,imagesc(extract_xz(elliptical_axis)); axis image

radius = linspace(0,pi,100);
cosineSampler = (1 + cos(radius))/2;
% figure, plot(cosineSampler)
%filter = zeros(size_x,size_y,size_z);
filter = interp1(linspace(0,1,length(cosineSampler)),cosineSampler, elliptical_axis);
filter = filter.*elliptical_axis_mask;

filteredImage = filter.*image;

