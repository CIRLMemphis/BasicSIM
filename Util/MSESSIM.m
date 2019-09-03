function [ MSE, SSIM ] = MSESSIM( ObEst, Ob )
% by Hasti Shabani on Jan 2019
MSE   = mean( (ObEst(:)-Ob(:)).^2 );
mu1   = mean(ObEst(:)); mu2 = mean(Ob(:));
var1  = var(ObEst(:)); var2 = var(Ob(:));
cov12 = cov( ObEst(:), Ob(:) );
SSIM  = ( (2*mu1*mu2) * (2*cov12(1,2)) )/( ( mu1^2 + mu2^2 ) * ( var1 + var2 ) );
end
