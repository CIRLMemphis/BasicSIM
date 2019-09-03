function gradXi = PCGradient(diff, xi, h, im, jm)
[Y, X, Z, Nthe, Nphi, Nm] = size(jm);
gradXi = zeros(Y, X, Z);
for l = 1:Nthe
    for k = 1:Nphi
        for m = 1:Nm
            gradXi = gradXi + conj(jm(:,:,:,l,k,m)).*IFT( conj(FT(h.*im(:,:,:,l,k,m))) .* FT(diff(:,:,:,l,k)) );
        end
    end
end
gradXi = -real(4.*xi.*gradXi);
end