run("../CIRLSetup.m");

%% Initialization
[ psfpar, psfpari ] = PSFConfig();
p     = psfpar.initialize(psfpar, 'Vectorial', 200);
X     = 200;       % discrete lateral size in voxels
Y     = 200;       % discrete lateral size in voxels
Z     = 600;       % discrete axial size in voxels
M     = 63;        % Experimetal magnification
dXY   = 6.5/M;     % lateral voxel scaling in microns ---- for 63X lens (6.5/63)....for 60X lens (6.4/63)
dZ    = 0.1;       % axial voxel scaling in microns
uc    = 2*psfpar.NA/psfpari.v(1);  % cycle/um
phi   = [96.0,   13.0,  -89.2310];     % phases for 2D-SIM
theta = 0;
u     = 0.5*uc;
w     = 0.07625*u;
wD    = 0.0001; 
phizDeg   = 33.5;
contrast  = 1.0;
attenRate = 0;
obScale   = 1;

Radius    = 6/2;      % radius of bead in microns
Thickness = 4/2;      % shell thickness of bead in microns

ob = 1e4*SphericalShell(X, Y, Z, dXY, Radius, Thickness);
h  = PSFLutz(X, Z, dXY, dZ, p);
[im, jm, Nn] = Tunable3DPattern3Slits(X, Y, Z, u, w, dXY, dZ, phi, theta, phizDeg, contrast, attenRate);
g = ForwardModelTunable(ob, h, im, jm);

%% which index of phi to estimate the parameter
kPhi = 1;

%% find omegaXY
gS = g(:, 1+Y/2, 1+Z/2,1,kPhi);
gY = abs(fft(gS));
gL = X;
gP2 = abs(gY/gL);
gP1 = gP2(1:gL/2+1);

gf = (0:(gL/2))/(gL*dXY);
figure; plot(gS);
figure; plot(gf, gP1); xlabel('f (Hz)'); ylabel('intensity')
peakNo = 1;
findpeaks(gP1(:),gf,'SortStr','descend', 'NPeaks', peakNo)
[peaks, locs] = findpeaks(gP1(:),gf,'SortStr','descend', 'NPeaks', peakNo); 
estOmegaXY = locs(1)

%% find omegaZ
gS = squeeze(g(1+Y/2, 1+X/2, :,1,kPhi));
gY = abs(fft(gS));
gL = Z;
gP2 = abs(gY/gL);
gP1 = gP2(1:gL/2+1);

gf = (0:(gL/2))/(gL*dZ);
figure; plot(gS);
figure; plot(gf, gP1); xlabel('f (Hz)'); ylabel('intensity')
peakNo = 1;
findpeaks(gP1(:),gf,'SortStr','descend', 'NPeaks', peakNo)
[peaks, locs] = findpeaks(gP1(:),gf,'SortStr','descend', 'NPeaks', peakNo); 
estOmegaZ = locs(1)/estOmegaXY

%% find peak of the PSF
hZ = h(1+Y/2, 1+X/2, :);
findpeaks(hZ(:),'SortStr','descend', 'NPeaks', peakNo);
[peaks, locs] = findpeaks(hZ(:),'SortStr','descend', 'NPeaks', peakNo);
hPeakLoc = locs(1)
phiZ = 2*pi/2 - 2*pi*estOmegaZ*hPeakLoc*dZ