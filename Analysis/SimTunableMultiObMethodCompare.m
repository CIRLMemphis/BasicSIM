run("../CIRLSetup.m");
colormapSet = 'gray';
colorScale  = [0 1.2];

%% load the reconstruction results
expNames = ["201908211658_SimTunableGWFMultiOb",...
            "SimTunableMBMultiOb256Iter200",...
            "201908231109_SimTunableMBMultiOb256Iter1000",...
            "201908191954_SimTunableMBPCMultiOb256Iter200"];
load(CIRLDataPath + "\Results\" + expNames(1) + "\" + expNames(1) + ".mat",...
     'X', 'Y', 'Z', 'dXY', 'dZ', 'reconOb');

%% load the original high resolution object
X2 = X*2;
Y2 = Y*2;
Z2 = Z*2;
HROb = MultiObject(X*2, Z*2, dXY/2, dZ/2);

%% True Object
z2BF      = 1 + Z2/2;
y2BF      = 1 + Y2/2;
midOff   = 41;
midSlice = y2BF-midOff-1:y2BF+midOff-1;
TrueObFig = figure('Position', get(0, 'Screensize'));
subplot(3,1,1); 
imagesc(HROb(:,:,z2BF)); axis square; colormap(colormapSet); colorbar;
xlabel('x'); ylabel('y'); title('True Object');
subplot(3,1,2);
imagesc(squeeze(HROb(y2BF,:,:))'); axis square; colormap(colormapSet); colorbar;
xlabel('x'); ylabel('z');
subplot(3,1,3);
imagesc(HROb(midSlice, midSlice, z2BF)); axis square; colormap(colormapSet); colorbar;
xlabel('x'); ylabel('z'); title('Zoomed-in middle');
saveas(TrueObFig, "TrueObject.jpg");

%% Reconstruction images of different methods
recVars = {};
lThe    = 1;
kPhi    = 1;
recVars{end+1} = HROb;
for k = 1:length(expNames)
    load(CIRLDataPath + "\Results\" + expNames(k) + "\" + expNames(k) + ".mat", 'reconOb');
    recVars{end+1} = reconOb./sum(reconOb(:))*sum(HROb(:));
end

MethodCompareFig = XYXZSubplot( recVars, z2BF, y2BF, ...
                                ["True Object", "GWF", "MB 200 Iter", "MB 1000 Iter", "MBPC 200 Iter"],...
                                "Comparison of different reconstruction methods",...
                                colormapSet, midSlice, colorScale);
saveas(MethodCompareFig, "TunableMethodComparison.jpg");
