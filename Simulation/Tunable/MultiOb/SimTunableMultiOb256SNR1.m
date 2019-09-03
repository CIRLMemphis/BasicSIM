run("SimTunableMultiOb256Setup.m");
matFile = CIRLDataPath + "/Simulation/Tunable/SimTunableMultiOb256SNR1.mat";

%% run forward model and save the results into CIRLDataPath
ob = MultiObject(X, Z, dXY, dZ);
g  = ForwardModel(ob, h, im, jm);

% add Poisson noise
b = 0.0168; % 1.5% of the signal is background
scaleCCA = 29800;
for l = 1:length(theta)
    for k = 1:length(phi)
        [temp, SNR] = AddPoissnNoise(g(:,:,:,l,k),b,scaleCCA);
        g(:,:,:,l,k) = temp;
    end
end

save(matFile, '-v7.3', 'g', 'ob');