run("SimTunableBead100Setup.m");
matFile = CIRLDataPath + "/Simulation/Tunable/SimTunableBead100.mat";

%% run forward model and save the results into CIRLDataPath
Radius    = 1/2;
Thickness = 0.5/2;
ob = SphericalShell(X, Y, Z, dXY, Radius, Thickness);
g  = ForwardModel(ob, h, im, jm);
save(matFile, '-v7.3', 'g');