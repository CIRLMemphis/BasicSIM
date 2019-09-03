% Vectorial PSF calculation using Gibson/Lanni OPD on Török/Sheppard model (Haeberle paper)
% vectorialpsf( r, z, p )
% r     : Absolute position in transverse direction [µm]
% z     : Absolute position in axial direction [µm]
% p     : Paraemter structure

function y = vectorialpsf(r, z, p)
% if (~isfield(p, 'theory') || ~strcmp(p.theory, 'Vectorial'))
%     p = p.initilaize(p, 'Vectorial', 100); % emergeny init
% end

k0 = p.k(1);
k1 = k0 * p.n(1);

barg = r * k1 * p.sinTheta1;
j0 = real(besselj(0, barg));
j1 = real(besselj(1, barg));
j2 = real(besselj(2, barg));
%j2 = -(j0 - 2*j1./barg); % faster?

% Optical Path Difference
OPD = p.opd(p.opdArg, z, p);

f = p.fw .* exp(1i * k0 * OPD);
I0 = sum(f .* j0 .* p.tau1);
I1 = sum(f .* j1 .* p.tau2);
I2 = sum(f .* j2 .* p.tau3);
if p.amplitudepsf == false
    % identical to: evector(I0, I1, I2, pi/4)*evector(I0, I1, I2, pi/4)'
    y = I0*I0' + 2*(I1*I1') + I2*I2';
else
    E = evector(I0, I1, I2, p.polangle);
    % "The role of specimen induced sperical aberrration in confocal
    % microscopy" Török et. al eq (5)!
    y = sum(E);
end
end

function y = evector(I0, I1, I2, pol)
if isfinite(pol)
    Ex = -1i*(I0+I2*cos(2*pol));
    Ey = -1i*(I2*sin(2*pol));
    Ez = -2*I1*cos(pol);
    y = [Ex Ey Ez];
else
    y = -1i*I0; % result of integration over 2 pi polarization angles
end
end