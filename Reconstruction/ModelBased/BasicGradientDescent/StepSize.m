function curStepSize = StepSize(diff, d, h, im, jm)
[Y, X, Z, Nthe, Nphi, Nm] = size(jm);
bot  = 0;
top  = 0;
A    = zeros(Y, X, Z);
for l = 1:Nthe
    for k = 1:Nphi
        A(:) = 0;
        for m = 1:Nm
            A = A + real(IFT( FT(d.*jm(:,:,:,l,k,m)) .* FT(h.*im(:,:,:,l,k,m)) ));
        end
        diffkl = squeeze(diff(:,:,:,l,k));
        bot    = bot + dot(A(:), A(:));
        top    = top + dot(A(:), diffkl(:));
    end
end

curStepSize = top/bot;
end