function mask = SQUBICwrapped(A,NA,n,lambda,dx,R,varargin)
% mask = SQUBICwrapped(A,NA,n,lambda,dx,R,varargin)
% MATLAB function to computer wrapped SQUBIC phase mask with given
% specification . MAsk is also centered at the pupil. 
% (no need to cropping or resizing)
% resizing
% Author : Nurmohammed Patwary; Date : 11/26/2013; CIRL
% input
% A  = mask constant
% NA = NA of Onjective lens
% n  = immersion medium index;
% lambda = immision wavelength
% dx = PSF lateral sampling
% R  = PSF lateral dimension
% ovs = oversampling , default = 1
% ovr = overranging  , default = 1;
% (ovs and ovr should be used simultaneously)

if nargin > 6
    ovs = varargin{1};
    ovr = varargin{2};
    GaussApodizer  = 1;
else
    ovr = 1;
    ovs = 1;
    GaussApodizer  = 1;
end
%% Parameter Set ------- start  

% NA     = 1.4;     % Obejctive lens NA
% n      =  1.515;  % immersion medium RI
% A      = 88;      % SQUBIC mask constatnt
% dx     = 0.1 ;    % PSF sampling (um)
% ovs    = 2;       % over-sampling
% ovr    = 2;       % over-ranging
% R      = 128 ;     % lateral simension
% lambda = 0.515; % um

%% Parameter Set ------- end 
dxOvs = dx/ovs;
Rnew  = R*ovr*ovs ;
alfa  = asin(NA/n);
fmax  = 1/(dxOvs) ;
df    = fmax/Rnew ;
fx = -fmax/2:df:fmax/2-df;
fy = fx ;
fc = NA/lambda;
fxN = fx/fc; fyN = fy/fc;
[px,py] = meshgrid(fxN,fyN);
pupilAp = double(sqrt(px.^2+py.^2)<=1);

%% adding gaussian apodizer
if nargin > 8
   sigma = varargin{3};
   %sigma = fc/5 ;
   d = 2*sigma^2;
   GaussApodizer = exp(-(px.^2+py.^2)/d); 
end
mask = 2*pi*A*((sqrt(1-sin(alfa)^2*(px.^2+py.^2))-1)/(1-cos(alfa)) + 0.5).^3;
mask = mask.*pupilAp;
i = sqrt(-1);
mask = GaussApodizer.*exp(i*mask);

% figure, imagesc(GaussApodizer); colorbar
% figure, plot(GaussApodizer(:,255))
% figure, imagesc(angle(mask)); colorbar
% figure, imagesc(abs(mask)); colorbar
