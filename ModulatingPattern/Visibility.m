function Vz = Visibility(z, omegaZ, Nslits, phiz)
Vz = ones(size(z));
for n = 1:((Nslits-1)/2)
    Vz = Vz + 2*cos(2*n*(2*pi*omegaZ*z + phiz));
end
Vz = Vz/Nslits;
end