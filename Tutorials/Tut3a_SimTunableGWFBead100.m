%% load the CIRL settings
run("../CIRLSetup.m")

%% load the experiment setup (in this case it is simulated setup)
run("SimTunableBead100Setup.m");

%% load the collected data (in this case simulated data)
matFile = CIRLDataPath + "/Simulation/Tunable/SimTunableBead100.mat";
load(matFile, 'g');

%% construct the point-spread function (PSF)
h  = PSFAgard(X, Z, dXY, dZ);

%% load the modulating patterns
[im, jm, ~] = PatternTunable3DNSlits(X, Y, Z, um, wm, dXY, dZ, phi, offs, theta, phizDeg, Nslits);

%% run the GWF reconstruction and get the restored image
wD       = 1e-6;
reconImg = GWFTunable3D(g, h, im, uc, um, phi, offs, theta, wD, dXY, dZ);