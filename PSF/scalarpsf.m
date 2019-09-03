% Scalar PSF calculation using Gibson & Lanni OPD
% scalarpsf( r, z, p )
% r     : Absolute position in transverse direction [µm]
% z     : Absolute position in axial direction [µm]
% p     : Paraemter structure

function y = scalarpsf(r, z, p)
k0 = p.k(1);
barg = r*k0*sqrt(p.x);
j0 = besselj(0, barg);
y1 = j0 .* exp(1i*k0 * p.opd(p.x, z, p));
y = sum(y1 .* p.w) / p.NA^2;
if p.amplitudepsf == false
    y = abs(y).^2;
end
end
