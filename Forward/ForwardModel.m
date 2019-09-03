% see section [TODO] in the documentation
function g = ForwardModel( ob, h, im, jm)
[X, Y, Z, Nthe, Nphi, Nm] = size(jm);
g = zeros(X,Y,Z,Nthe,Nphi);
for l = 1:Nthe
    for k = 1:Nphi
        G = zeros(X,Y,Z);
        for m = 1:Nm
            G = G + FT(ob.*jm(:,:,:,l,k,m)).*FT(h.*im(:,:,:,l,k,m));
        end
        g(:,:,:,l,k) = real(IFT(G));
    end
end
