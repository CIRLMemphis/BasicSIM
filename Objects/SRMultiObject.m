function multiOb = SRMultiObject(xMin, xMax, xN, shouldPlot)
if (nargin < 4)
    shouldPlot = 0;
end
xDelta  = (xMax-xMin)/(xN-1);
xRange  = zeros(xN,1);
for n = 1:xN
    xRange(n) = xMin + (n-1)*xDelta;
end

tinyR   = 0.06;
smallR  = 0.11;
largeR  = 0.125;
amp     = 1;
multiOb = GaussianBead(0,0,0,tinyR,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0.1 , 0   , 0   ,tinyR ,amp,xRange,0);
multiOb = multiOb + GaussianBead(-0.1 , 0   , 0   ,tinyR ,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0.25, 0   , 0   ,smallR,amp,xRange,0);
multiOb = multiOb + GaussianBead(-0.25, 0   , 0   ,smallR,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0.55, 0   , 0   ,largeR,amp,xRange,0);
multiOb = multiOb + GaussianBead(-0.55, 0   , 0   ,largeR,amp,xRange,0);

multiOb = multiOb + GaussianBead( 0   , 0.1 , 0   ,tinyR ,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0   ,-0.1 , 0   ,tinyR ,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0   , 0.25, 0   ,smallR,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0   ,-0.25, 0   ,smallR,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0   , 0.55, 0   ,largeR,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0   ,-0.55, 0   ,largeR,amp,xRange,0);

multiOb = multiOb + GaussianBead( 0   , 0   ,-0.25,smallR,amp,xRange,0);
multiOb = multiOb + GaussianBead( 0   , 0   ,-0.55,largeR,amp,xRange,0);

% Radius  = 3/2;
% Thickn  = 0.4/2;
% outBead = bead(xDelta, xDelta, xN, xN, Radius, Thickn);

multiOb = multiOb/max(multiOb(:));
%multiOb = multiOb + outBead;

xMid = floor(xN/2) + 1;
if (shouldPlot)
    figure; imagesc(multiOb(:,:,xMid)); axis square;
    figure; imagesc(squeeze(multiOb(xMid,:,:))'); axis square;
    figure; plot(xRange, multiOb(xMid,:,xMid));
end

end