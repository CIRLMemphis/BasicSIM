% Widefield PSF calculation
% wfpsf( r, z, p )
% r     : Absolute position in transverse direction [microns]
% z     : Absolute position in axial direction [microns]
% p     : Paraemter structure

function y = wfpsf(r, z, p)
if (~isfield(p, 'theory'))
    p = p.initialize(p, 'Scalar', 100); % emergeny init
end

switch p.theory
    case 'Scalar'
        psffunc = @scalarpsf;
    case 'Vectorial'
        psffunc = @vectorialpsf;
end

if size(r,2) > 1 && size(z,2) == 1
    y = zeros(size(r));
    for j = 1:size(r,2)
        y(1,j) = psffunc(r(j), z, p);
    end

elseif size(z,2) > 1 && size(r,2) == 1
    y = zeros(size(z));
    for j = 1:size(z,2)
        y(j,1) = psffunc(r, z(j), p);
    end

elseif size(z,2) > 1 && size(r,2) > 1
    y = zeros(size(z, 2), size(r, 2));
    for j = 1:size(z,2)
        for k = 1:size(r,2)
            y(j,k) = psffunc(r(k), z(j), p);
        end
    end

else
    y = psffunc(r, z, p);
end
end
