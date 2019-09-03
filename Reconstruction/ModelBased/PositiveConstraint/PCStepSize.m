function curStepSize = PCStepSize(g0, ForwardFct, CostFct, xi, d, h, im, jm)
[Y, X, Z, Nthe, Nphi] = size(g0);
Nm  = size(im, 6);
A1  = zeros(Y, X, Z, Nthe, Nphi);
A2  = zeros(Y, X, Z, Nthe, Nphi);
A3  = zeros(Y, X, Z, Nthe, Nphi);
for l = 1:Nthe
    for k = 1:Nphi
        for m = 1:Nm
            FThim         = FT(h.*im(:,:,:,l,k,m));
            A1(:,:,:,l,k) = A1(:,:,:,l,k) + real(IFT( FT(xi.*xi.*jm(:,:,:,l,k,m)) .* FThim ));
            A2(:,:,:,l,k) = A2(:,:,:,l,k) + real(IFT( FT(d .*xi.*jm(:,:,:,l,k,m)) .* FThim ));
            A3(:,:,:,l,k) = A3(:,:,:,l,k) + real(IFT( FT(d .*d .*jm(:,:,:,l,k,m)) .* FThim ));
        end
    end
end
A1 = g0 - A1;
A2 = -A2;
A3 = -A3;
AA =  4*dot(A3(:), A3(:));
BB = 12*dot(A3(:), A2(:));
CC =  8*dot(A2(:), A2(:)) + 4*dot(A1(:), A3(:));
DD =  4*dot(A1(:), A2(:));

loc_alpha  = roots([ AA BB CC DD ]);
cost_alpha = zeros(length(loc_alpha),1);

for k = 1:length(loc_alpha)
    cost_alpha(k) = CostFct(g0, ForwardFct, xi + loc_alpha(k)*d, h, im, jm);
end

[~, ind]    = min(real(cost_alpha));
curStepSize = loc_alpha(ind);
end