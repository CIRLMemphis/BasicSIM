function M = PhaseMatrix(Phase, offDeg, cn, qn)
phi  = pi*Phase/180;
off  = pi*offDeg/180;
Nphi = length(phi);
M    = zeros(Nphi, Nphi);
for k = 1:Nphi
    for n = 1:Nphi
        M(k,n) = cn(n)*exp(+1i*qn(n)*phi(k) + off);
    end
end
end