%% load the CIRL settings
run("../CIRLSetup.m")

%% load the experiment setup (in this case it is simulated setup)
run("SimTunableBead100Setup.m");

%% load the collected data (in this case simulated data)
matFile = CIRLDataPath + "/Simulation/Tunable/SimTunableBead100.mat";
load(matFile, 'g');

%% increase the resolution grid
X     = 2*X;
Y     = 2*Y;
Z     = 2*Z; 
dXY   = dXY/2;
dZ    = dZ/2;

%% construct the high-resolution point-spread function (PSF)
h  = PSFAgard(X, Z, dXY, dZ);

%% load the high-resolution modulating patterns
[im, jm, ~] = PatternTunable3DNSlits(X, Y, Z, um, wm, dXY, dZ, phi, offs, theta, phizDeg, Nslits);

%% run the model-based reconstruction and get the restored image
numIt    = 10;       % set the number of iterations
picIn    = numIt;    % picture every 5 interations
reconImg = GradientDescent(@ForwardModel, ...
                           @CostFunction, ...
                           @Gradient, ...
                           @StepSize, ...
                           g, h, im, jm, numIt ,...
                           5e-20 ,-1, -1, picIn);
