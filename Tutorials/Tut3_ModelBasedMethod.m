%% Tutorial 3: using model-based method to reconstruct the noiseless
%  simulated bead data.

%% 1. Check if you have the data file at
%       CIRLDataPath + "\Simulation\Tunable\SimTunableBead100.mat"
%     If not, run the tutorial 2 again to get that data file.

%% 2. Run the script "Tut3b_SimTunableMBBead100Iter100.m", which run the
%     model-based reconstruction method for 10 iterations to get the 
%     restored image.

%% 3. Compare the restored image (after 10 iterations) with the original
%     object (see tutorial 1 or 2), by using xy, xz pictures, MSE and SSIM.

%% 4. Same questions as in 2. and 3., but with 100 iterations.

%% 5. Save the restored image (of 100 iterations as in 4.) at
%       CIRLDataPath + "\Results\Tunable\SimTunableBead100Results.mat"