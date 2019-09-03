% This setup is based on Hasti's simulation parameters
% with one theta, smaller grid
%%
run("../../../CIRLSetup.m");

%% Simulated 3W star corner settings
[ psfpar, psfpari ] = PSFConfigNoAber();
X     = 200;       % discrete lateral size in voxels
Y     = 200;       % discrete lateral size in voxels
Z     = 200;        % discrete axial size in voxels
dXY   = 0.025;     % lateral voxel scaling in microns ---- for 20X lens (6.4/20)....for 60X lens (6.4/63)
dZ    = 0.025;     % axial voxel scaling in microns
uc    = 2*psfpar.NA/psfpari.v(1);  % cycle/um
offs  = [0, 0, 0];
phi   = [0, 72, 144, 216, 288];
theta = [0, 60, 120];
u     = [0.8, 0.8, 0.8]*uc;
w     = 0.33*u;
phizDeg   = 300.0;

%% get the pattern and check
zBF = 1 + Z/2;
% p  = psfpar.initialize(psfpar, 'Vectorial', 200);
% h  = PSFLutz(X, Z, dXY, dZ, p);
h  = PSFAgard( X, Z, dXY, dZ);
[im, jm, Nn] = Pattern3W3D(X, Y, Z, u, w, dXY, dZ, phi, offs, theta, phizDeg);
vz = squeeze(im(1+Y/2,1+X/2,:,1,1,3));
vz = vz./max(vz(:));
hz = squeeze(h (1+Y/2,1+X/2,:));
hz = hz./max(hz(:));
figure;  plot(vz, 'DisplayName', 'v(z)'); 
hold on; plot(hz, 'DisplayName', 'h(z)'); 
xlabel('z'); ylabel('value'); suptitle("Visibility and PSF at zBF = " + num2str(zBF)); legend;

jm2 = squeeze(jm(1+Y/2,:,zBF,1,1,2));
jm3 = squeeze(jm(1+Y/2,:,zBF,1,1,3));
figure;  plot(jm2, 'DisplayName', 'jm(2)'); 
hold on; plot(jm3, 'DisplayName', 'jm(3)'); 
xlabel('x'); ylabel('value'); suptitle("jm at zBF = " + num2str(zBF)); legend;