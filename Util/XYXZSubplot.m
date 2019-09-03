function fig = XYXZSubplot(vars, zBF, yBF, colTitles, supTitle, colormapSet, xyZoomRange, colorScale)
nRow = 2;
if (nargin > 6)
    nRow = 3;
end
if (nargin < 6)
    colormapSet = 'gray';
end
if (nargin < 8)
    colorScale = [0 1.2];
end
nVars = length(vars);
fig   = figure('Position', get(0, 'Screensize'));
[ha, pos] = TightSubplot(nRow,nVars,[.01 .001],[.01 .03],[.01 .01]);
for k = 1:nVars
    curVar  = vars{k};
    if (zBF > size(curVar,3))
        yBFCur = 1 + size(curVar,1)/2;
        zBFCur = 1 + size(curVar,3)/2;
        xyZoomRangeCur = round(xyZoomRange/2);
    else
        yBFCur = yBF;
        zBFCur = zBF;
        xyZoomRangeCur = xyZoomRange;
    end
    axes(ha(k+(1-1)*nVars));
    imagesc(curVar(:,:,zBFCur)); axis square off; colormap(colormapSet);
    caxis(colorScale);
    if (~isempty(colTitles))
        title(colTitles(k));
    end
    axes(ha(k+(2-1)*nVars));
    imagesc(squeeze(curVar(yBFCur,:,:))'); axis square off; colormap(colormapSet);
    caxis(colorScale);
    if (nRow == 3)
        axes(ha(k+(3-1)*nVars));
        imagesc(curVar(xyZoomRangeCur,xyZoomRangeCur,zBFCur)); axis square off; colormap(colormapSet); 
        caxis(colorScale);
    end
end
if (~isempty(supTitle))
    suptitle(supTitle);
end
end