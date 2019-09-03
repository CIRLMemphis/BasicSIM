load(CIRLDataPath + '/Data_20190408_6umBead_63x1p4NA.mat', 'g');
[ psfpar, psfpari ] = PSFConfig();
p     = psfpar.initialize(psfpar, 'Vectorial', 200);
X     = 200;       % discrete lateral size in voxels
Y     = 200;       % discrete lateral size in voxels
Z     = 600;       % discrete axial size in voxels
M     = 63;        % Experimetal magnification
dXY   = 6.5/M;     % lateral voxel scaling in microns ---- for 63X lens (6.5/63)....for 60X lens (6.4/63)
dZ    = 0.1;       % axial voxel scaling in microns
uc    = 2*psfpar.NA/psfpari.v(1);  % cycle/um

%load(CIRLDataPath + '/201907240846.mat', 'g');
[X,Y,Z,Nthe,Nphi] = size(g);
figure;plot(g(1+Y/2,:,1+Z/2,1,1))
figure;plot(abs(FT(g(1+Y/2,:,1+Z/2,1,1))));

%% find omegaXY
kPhi = 1;
gFT  = squeeze(abs(FT(g(1 + Y/2, :, 1 + Z/2, kPhi))));
gFT  = gFT./max(gFT(:));

peakNo = 5;
[peaks, locs] = findpeaks(gFT(:),'SortStr','descend');
peaks  = peaks(1:peakNo);
locs   = locs(1:peakNo);
freqs  = abs(locs - locs(1))*dXY/uc;
estOmegaXY = freqs(peakNo)/2
peaks(peakNo)

%% find omegaZ
kPhi = 1;
gFT  = squeeze(abs(FT(g(1 + Y/2, 1 + X/2, :, kPhi))));
gFT  = gFT./max(gFT(:));

peakNo = 5;
[peaks, locs] = findpeaks(gFT(:),'SortStr','descend');
peaks  = peaks(1:peakNo);
locs   = locs(1:peakNo);
freqs  = abs(locs - locs(1))*dZ;
estOmegaZ = freqs(peakNo)
peaks(peakNo)

%%
[peaks, locs] = findpeaks(gFT(:),'SortStr','descend', 'NPeaks', peakNo); 
figure;
subplot(1,2,1); plot(squeeze(g(1+Y/2, :, 1+Z/2, 1, 2))); xlabel('x'); ylabel('amplitude'); title('g(x)'); set(gca,'FontSize',20)
subplot(1,2,2);
findpeaks(gFT(:),'SortStr','descend', 'NPeaks', peakNo); 
text(locs+.02,peaks,num2str((1:numel(peaks))'));
xlabel('x'); ylabel('amplitude'); title('G(x)'); set(gca,'FontSize',20)

%%
phi   = [-89.2310, 13.0, 96.0];
theta = 0;
u     =    0.4175*uc/2; % 0.45*uc;0.9281;
w     = 0.07625*u;

phizDeg   = -53.5;
contrast  = 1.0;
attenRate = 0;
h  = PSFLutz(X, Z, dXY, dZ, p);
[im, jm, Nn] = Tunable3DPattern3Slits(X, Y, Z, u, w, dXY, dZ, phi, theta, phizDeg, contrast, attenRate);

Vz   = im(:,:,:,1,1,2);
curH = h(1+Y/2, 1+X/2, :);
curH = curH./max(curH);
figure;
imagesc(squeeze(Vz(1+Y/2, :, :)));
figure;
plot(squeeze(Vz(1+Y/2, 1+X/2, :)));
hold on;
plot(squeeze(curH));



%% Example of computing frequency
dXY = 0.1;
L = 200*dXY;          
t = 0:0.1:L-1;        
f1 = 0.15;
A1 = 0.7;
f2 = 0.4;
A2 = 1;
S = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = (0:(L/2))/L;
figure; plot(t, S);
figure; plot(f, P1); xlabel('f (Hz)'); ylabel('intensity')

%% Applied to real data
gS = g(1+Y/2, :, 1+Z/2,1,2);
gY = fft(gS);
gL = X;
gP2 = abs(gY/gL);
gP1 = gP2(1:gL/2+1);
gP1(2:end-1) = 2*gP1(2:end-1);

gf = (0:(gL/2))*dXY;
figure; plot(gS);
figure; plot(gf, gP1); xlabel('f (Hz)'); ylabel('intensity')
% find the second peaks and devide by dXY