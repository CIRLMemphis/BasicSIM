function [recon, retFig, retVars] = PCGradientDescent( ForwardFct, CostFct, GradientFct, StepSizeFct, g, h, im, jm, numIt, penalizationParam, initGuess, selectDir, picInterval)
fprintf('Call to %s\n',  mfilename);
retFig  = [];
retVars = {};
DEBUG_DISPLAY = 1;

if(nargin < 9)
    numIt = 10;
end

if(nargin < 10 || isequal(penalizationParam , -1))
    penalizationParam = 1e-8;
end

if(nargin < 12 || isequal(selectDir , -1) )
    selectDir = 2;
end

if(nargin < 13)
    picInterval = -1;
end

% normalize the data and zero-padding
[Y, X, Z, Nthe, Nphi] = size(g);
g2    = zeros(Y*2, X*2, Z*2, Nthe, Nphi);
for l = 1:Nthe
    for k = 1:Nphi
        g2(:,:,:,l,k) = real(IFT(padarray(FT(g(:,:,:,l,k)),[Y/2 X/2 Z/2])));
    end
end

[Y, X, Z, Nthe, Nphi] = size(g2);
if(nargin < 11 || isequal(initGuess , -1))
    initGuess = sum(reshape(g2, Y, X, Z, Nthe*Nphi), 4)/(Nthe*Nphi);
end
recon    = sqrt(initGuess);

tic;
for it = 1:numIt
    diff    = g2 - ForwardFct(recon.^2, h, im, jm);
    curCrit = dot(diff(:), diff(:));
    curGrad = GradientFct(diff, recon, h, im, jm);
    if (it == 1)
        memGrad  =  curGrad;
        desctDir = -curGrad;
    end
    % select desct dir
    switch selectDir
        case 1
            desctDir = -curGrad;
        case 2
            temp     = dot(curGrad(:),(curGrad(:) - memGrad(:)))/ dot(memGrad(:),memGrad(:));
            desctDir = curGrad + temp*desctDir;
        case 3
            desctDir = - ifftn(  fftn(reshape(curGrad,curSize)) ./ precond  );
            desctDir = desctDir(:);
        case 4
            desctDir = - ifftn(  fftn(reshape(curGrad,curSize)) ./ precond  );
            desctDir = desctDir(:);
        otherwise
            desctDir = -curGrad;
    end
    
    alpha = StepSizeFct(g2, ForwardFct, CostFct, recon, desctDir, h, im, jm);
    if(DEBUG_DISPLAY)
        fprintf('It : %d \n',it);
        fprintf('Alpha : %03.2e    crit : %d\n',alpha, curCrit);
    end
        
    recon = recon + alpha.*desctDir;
    memGrad = curGrad;
    
    if (picInterval ~= -1 && mod(it, picInterval) == 0)
        recon2         = recon.^2;
        retFig(end+1)  = figure('Position', get(0, 'Screensize'));
        imagesc(recon2(:,:,1+round(Z/2)));
        xlabel('x'); ylabel('y'); colorbar; axis square; colormap jet;
        title("it = " + num2str(it));
        retVars{end+1} = recon2;
    end
end
recon = recon.^2;
toc;