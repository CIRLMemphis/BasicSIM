run("../../../CIRLSetup.m");
matFile = CIRLDataPath + "/2019-04-08 New6umBead 63x1p4NA SIM/Data_20190408_6umBead_63x1p4NA.mat";

%% calibrated parameters
[ psfpar, psfpari ] = PSFConfig();
p  = psfpar.initialize(psfpar, 'Vectorial', 200);
X    = 200;   % discrete lateral size in voxels
Y    = 200;   % discrete lateral size in voxels
Z    = 600;   % discrete axial size in voxels
M    = 63;    % Experimetal magnification
dXY  = 6.5/M; % lateral voxel scaling in microns ---- for 63X lens (6.5/63)....for 60X lens (6.4/63)
dZ   = 0.1;   % axial voxel scaling in microns

uc    = 2*psfpar.NA/psfpari.v(1);  % cycle/um
phi   = [-89.2310, 96.0, 13.0];
offs  = 0;
theta = 0;
u     =    0.19*uc; % 0.45*uc;0.9281;
w     = 0.07625*u;
phizDeg = 33.5;

%% get the pattern and check
zBF = 1+Z/2;
h  = PSFLutz(X, Z, dXY, dZ, p);
[im, jm, Nn] = PatternTunable3D3Slits(X, Y, Z, u, w, dXY, dZ, phi, offs, theta, phizDeg);
vz = squeeze(im(1+Y/2,1+X/2,:,1,1,2));
vz = vz./max(vz(:));
hz = squeeze(h (1+Y/2,1+X/2,:));
hz = hz./max(hz(:));
figure;  plot(vz, 'DisplayName', 'v(z)'); 
hold on; plot(hz, 'DisplayName', 'h(z)'); 
xlabel('z'); ylabel('value'); suptitle("Visibility and PSF at zBF = " + num2str(zBF)); legend;

jm2 = squeeze(jm(1+Y/2,:,zBF,1,1,2));
figure;  plot(jm2, 'DisplayName', 'jm(2)'); 
xlabel('x'); ylabel('value'); suptitle("jm at zBF = " + num2str(zBF)); legend;