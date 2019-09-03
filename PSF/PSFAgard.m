function h = PSFAgard( XY, Z, dXY, dZ)

% MATLAB code for Adarg PR implementation
% Author : Nurmohammed ; Date : 10/24/2013

NA       = 1.4;
lambda   = 0.515;
fc       = NA/lambda ;
n        = 1.518 ; % immersion medium
n1       = n;    % immersion medium
n2       = 1.47; % mounting medium
mask     = SQUBICwrapped(0,NA,n,lambda,dXY,XY);
% nn = 0;
% zero_mask = zeros(size(mask));
% zero_mask(nn+1:end,:) = mask(1:end-nn,:); 
% mask = zero_mask;
% mask = 1 % CCA PSF
depth    = 0 ;   % um
%figure(100),  imagesc(angle(mask)) ; axis image ; colorbar
% mask = 1;
%----parameters considering magnification----%

fmax  = 1/(dXY) ;
df    = fmax/XY ;
fx    = -fmax/2:df:fmax/2-df;
x        = fx;
N        = length(x);
[kx ky]  = meshgrid(x,x);
kz       = sqrt( (n/lambda)^2 - kx.^2 - ky.^2 );

%figure(1), subplot(311); imagesc(abs(kz)) ; axis image ; colorbar
%title('-------kz-------')
% figure(1), subplot(312); plot(abs(kz(:,round(length(x)/2)+1))) ; colorbar
% figure(1), subplot(313); plot(angle(kz(:,round(length(x)/2+1)))) ; colorbar

pupilap  = kx.^2+ky.^2 <= (NA/lambda)^2;     % defination of P(x,y)
kz = double(pupilap.*kz) ;
% figure(2); subplot(131) ; imagesc(pupilap) ; axis image ; colorbar ; title('pupil aperture')
pupil    = pupilap.*exp(2*pi*sqrt(-1)*kz);   % pupil function without considering distance z
% figure(2); subplot(132) ; imagesc(abs(pupil)) ;axis image; colorbar ; title('pupil magnitude')
% figure(2); subplot(133) ; imagesc(angle(pupil)) ;axis image; colorbar ; title('pupil phase')

%----parameters considering Spherical aberration----% start
% n1        = n;
% n2        = 1.33;
sinTheta1 = (lambda/n1)*(sqrt(kx.^2+ky.^2)); % using relation between kx,ky and sineTheta1 
sinTheta2 = (n1/n2)*sinTheta1 ;              % snell's law
cosTheta1 = sqrt(1-sinTheta1.^2);            % trigonometric algebra
cosTheta2 = sqrt(1-sinTheta2.^2);            % trigonometric algebra

OP        = depth*(n2*cosTheta2-n1*cosTheta1); % Optical path difference
% figure(20) ; subplot(121); imagesc(abs(OP)); axis image; colorbar ;  title('OP abs')
% figure(20) ; subplot(122); imagesc(angle(OP));axis image; colorbar ;  title('OP phase')
PhaseAbberation = exp(sqrt(-1)*2*pi*OP/lambda);
% figure(21) ; subplot(121); imagesc(abs(PhaseAbberation)); axis image; colorbar ;  title('PhaseAbberation abs')
% figure(21) ; subplot(122); imagesc(angle(PhaseAbberation));axis image; colorbar ;  title('PhaseAbberation phase')
% %----parameters considering Spherical aberration----% end

%z1        = [Z/2:-1:-Z/2+1]*dz;       % defocus distance   
z1        = [-Z/2:1:Z/2-1]*dXY;       % defocus distance         
z1 = -z1 ;% changing the direction

for n = 1:length(z1)
     defocus = exp(2*pi*sqrt(-1)*kz*z1(n));
     SA      = PhaseAbberation;
     pupil   =  defocus.*SA;
     pupil  = imresize(pupil,[200 250]);
%      figure(3) ; subplot(2,2,1); imagesc(angle(defocus)) ;axis image; colorbar ; title('pupil phase');
%      figure(3) ; subplot(2,2,2); imagesc(angle(SA)) ;axis image; colorbar ; title('pupil phase');
%      figure(3) ; subplot(2,2,3); imagesc(abs(defocus)) ;axis image; colorbar ; title('pupil phase');
%      figure(3) ; subplot(2,2,4); imagesc(abs(SA)) ;axis image; colorbar ; title('pupil phase');
    pupil  =  mask.*pupilap.*exp(2*pi*sqrt(-1)*kz*z1(n)).*PhaseAbberation;
    PSF    = fftshift(fft2(fftshift(pupil)))/(N*N);
%     figure(4) ; subplot(2,2,n); imagesc(abs(PSF)) ;axis image; colorbar ; title('PSF magnitude');
    zplane(:,:,n) = PSF; 
end
%figure, imagesc(abs(PSF)); colorbar

% intPSF = abs(zplane(230:270,230:270,:)).^2;
h = abs(zplane).^2;
h = h./sum(h(:));