function [noisy_image SNR]= AddPoissnNoise(image, b, scale)
% Author: Nurmohammed Patwary; Date: 01/27/2016
% This function adds noisy with the image.
% Scale is an user defined parameter.
% b = % of background signal. [1.5% to 2%]
% Syntex: noisy_image = AddPoissnNoise(image, scale)
[ x y z]      = size(image);

image          = image./max(image(:)) * scale;
image          = image + max(image(:)) * b;
%image          = image + image * b;
noisy_image    = poissrnd(image);
noisy_image    = noisy_image(:);
[index value]  = find(isnan(noisy_image));
noisy_image(index) = 0;
noisy_image    = reshape(noisy_image, [x y z]);

% Calculating SNR in dB
signal_energy = image.^2;
noise_energy  = (noisy_image-image).^2 ;
SNR = 10*log10(sum(signal_energy(:))/sum(noise_energy(:)));