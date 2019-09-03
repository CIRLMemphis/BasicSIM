function Fxi = PCCostFunction( g0, ForwardFct, xi, h, im, jm)
[~, ~, ~, Nthe, Nphi] = size(g0);
diff = g0 - ForwardFct(xi.^2, h, im, jm);
Fxi  = 0;
for l = 1:Nthe
    for k = 1:Nphi
        temp = diff(:,:,:,l,k);
        Fxi = Fxi + dot(temp(:), temp(:));
    end
end
end