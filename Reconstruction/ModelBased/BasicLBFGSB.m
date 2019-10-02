function [recon, retFig, retVars] = BasicLBFGSB( ForwardFct, CostFct, GradientFct, StepSizeFct, g, h, im, jm, numIt, penalizationParam, initGuess, selectDir, picInterval, gTransform)
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
if (nargin < 14)
    [Y, X, Z, Nthe, Nphi] = size(g);
    g2    = zeros(Y*2, X*2, Z*2, Nthe, Nphi);
    for l = 1:Nthe
        for k = 1:Nphi
            g2(:,:,:,l,k) = real(IFT(padarray(FT(g(:,:,:,l,k)),[Y/2 X/2 Z/2])));
        end
    end
else
    g2 = gTransform(g);
end

[Y, X, Z, Nthe, Nphi] = size(g2);
if(nargin < 11 || isequal(initGuess , -1))
    initGuess = sum(reshape(g2, Y, X, Z, Nthe*Nphi), 4)/(Nthe*Nphi);
end

% end
tic;
n = Y*X*Z;
f = @(x) norm(reshape(g2 - ForwardFct(reshape(x,Y,X,Z), h, im, jm), Y*X*Z*Nthe*Nphi, 1));
g = @(x) reshape(GradientFct(g2 - ForwardFct(reshape(x,Y,X,Z), h, im, jm), h, im, jm), Y*X*Z, 1);
% There are no constraints
l = -inf(n,1);
u = inf(n,1);
opts    = struct( 'x0', reshape(initGuess, Y*X*Z, 1) );
opts.printEvery     = 1;
opts.m  = 5;

% Ask for very high accuracy
opts.pgtol      = 1e-10;
opts.factr      = 1e3;

% The {f,g} is another way to call it
[recon,f,info] = lbfgsb( {f,g} , l, u, opts );
toc;