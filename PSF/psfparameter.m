% PSFPARAMETER function
% PSFPARAMETER( NA, ND, NU, W, CT, D, L )
% NA     : Numerical aperture objective
% ND     : Vector of design refractive indices [immersion, coverglass]
% NU     : Vector of actual refractive indices [immersion, coverglass, stratum embedding]
% DD     : Vector of design thickness [working distance, coverglass]
% DU     : Vector of actual thickness [0, coverglass, stratum embedding]
% L      : Vector of used wavelengths [detection, illumination]
% All units are in microns or 1/microns respectively
function p = psfparameter(na, nD, nU, dD, dU, l)
p = struct('NA'             , na             , ... % Numerical aperture
           'nD'             , nD             , ... % Design refractive Indices [immersion, coverglass]
           'n'              , nU             , ... % Actual Refractive Indices [immersion, coverglass, stratum embedding]
           'dD'             , dD             , ... % Design thickness [working distance, coverglass thickness]
           'd'              , dU             , ... % Actual thickness [0, coverglass, stratum embedding] in microns
           'v'              , l              , ... % [Emission wavelength, Illumination wavelength]
           'initialize'     , @init          , ... % Initalization function
           'opd'            , @opd           , ... % Optical path difference function
           'zShift'         , 0              , ... % additional translation component in axial (z) direction
           'amplitudepsf'   , false          , ... % set to true for complex amplitude PSF
           'polangle'       , nan            , ... % angle of linear polarization in radians (cylindrical coordinate system, pi/4 = radial or random polarization)
                                               ... % set to NaN for random polarization
           'polarmask'      , @polarphase    , ... % pupil phase mask function (polar)
           'cartmask'       , @cartesianphase, ... % pupil phase mask function (cartesian)
           'maskkind'       , 'none'         , ... % pupil phase mask kind 'none', 'cpm', 'gcpm' or 'scpm' (see S. Yuan & C. Preza(2011))
           'alpha'          , 20             , ... % (see S. Yuan & C. Preza(2011))
           'beta'           , -60            , ... % (see S. Yuan & C. Preza(2011))
           'omega'          , pi/2           , ... % (see S. Yuan & C. Preza(2011))
           'fresnelrings'   , 5              , ... % number of Fresnel rings for helix plate
           'helixstartangle', 0              , ... % start angle of helix
           'helixcount'     , 1              , ... % number of helices (e.g single, double ... etc)
           'overrange'      , 2              , ... % over range sampling for FFT based PM method (internally for better approximation)
           'oversampling'   , 2                ... % over sampling for FFT based PM method (internally for better approximation)
            );
        
for i = 1:length(p.v)
    p.k(i) = 2*pi/p.v(i);
end

if (nD(1) ~= nU(1) || nD(2) ~= nU(2) || nD(1) ~= nU(3) || dD(2) ~= dU(2) || dU(3) > 0)
    p.sa = true;
else
    p.sa = false;
end
end

function m = polarphase(par, r, p)
x = cos(p); y = sin(p);
m = r^3 * cartesianphase(par, x, y);
end

function m = cartesianphase(par, x, y)
switch par.maskkind
    case 'cpm'
        m = par.alpha * (x.^3 + y.^3);
    case 'gcpm'
        m = (par.alpha * (x.^3 + y.^3) + par.beta * (x.^2 .* y + x .* y.^2));
    case 'scpm'
        m = (par.alpha * (x.^3 + y.^3) + par.beta * (sin(par.omega * x) + sin(par.omega * y)));
    case 'helix'
        s = max(x(:));
        r = sqrt(x.^2 + y.^2);
        t = (atan2(y, x) + par.helixstartangle) * par.helixcount;
        m = zeros(size(x));
        L = par.fresnelrings / par.helixcount; % scale L with helix count
        for l=1:s^2*L
            lb = sqrt((l-1)/L);
            ub = sqrt(l/L);
            m  = m + l * t .* (r >= lb & r < ub);
        end
    otherwise
        m = zeros(size(x));
end
	% figure, imshow(atan2(sin(m), cos(m)),[]); % mask visualization
end

function y = init(p, mode, glRoots)
y = p;
alpha = asin(p.NA/p.nD(1));
% for 2pi inner integral
[y.xp, y.wp] = gaussl(0, 2*pi, glRoots*4);
switch mode
    case 'Scalar'
        [x, w] = gaussl(0, p.NA^2, glRoots);
        % unsure about apodisation
        sqrtCosAlpha = sqrt(cos(alpha*x/p.NA^2));
        % sqrtCosAlpha = cos(alpha*x/p.NA^2);
        w   = w.*sqrtCosAlpha;
        y.x = x;
        y.w = w;
    case 'Vectorial'
        [x, w] = gaussl(0, alpha, glRoots);
        n1 = p.n(1);
        n2 = p.n(2);
        n3 = p.n(3);
        % Angles
        y.sinTheta1 = sin(x);
        sinTheta2   = y.sinTheta1*n1/n2;
        sinTheta3   = sinTheta2*n2/n3;
        % avoid critical angle, enter total reflection
        if (sinTheta2(length(sinTheta2)) > 1)
            st2       = (sinTheta2 <= 1);
            sinTheta2 = not(st2) + st2 .* sinTheta2;
        end
        if (sinTheta3(length(sinTheta3)) > 1)
            st3       = (sinTheta3 <= 1);
            sinTheta3 = not(st3) + st3 .* sinTheta3;
        end
        cosTheta1 = sqrt(1 - y.sinTheta1.^2);
        cosTheta2 = sqrt(1 - sinTheta2.^2);
        cosTheta3 = sqrt(1 - sinTheta3.^2);

        % Fresnel Coefficients (opposite order for illumination)
        % t12s = 2*n1*cosTheta1./(n1*cosTheta1 + n2*cosTheta2);
        % t23s = 2*n2*cosTheta2./(n2*cosTheta2 + n3*cosTheta3);
        % t12p = 2*n1*cosTheta1./(n2*cosTheta1 + n1*cosTheta2);
        % t23p = 2*n2*cosTheta2./(n3*cosTheta2 + n2*cosTheta3);
        % taus = t12s.*t23s;
        % taup = t12p.*t23p;

        t21s = 2*n3*cosTheta3./(n3*cosTheta3 + n2*cosTheta2);
        t32s = 2*n2*cosTheta2./(n2*cosTheta2 + n1*cosTheta1);
        t21p = 2*n3*cosTheta3./(n2*cosTheta3 + n3*cosTheta2);
        t32p = 2*n2*cosTheta2./(n1*cosTheta2 + n2*cosTheta1);
        taus = t32s.*t21s;
        taup = t32p.*t21p;

        y.tau1   = taus + taup .* cosTheta3;
        y.tau2   = taup        .* sinTheta3;
        y.tau3   = taus - taup .* cosTheta3;
        y.opdArg = (n1 * y.sinTheta1).^2;
        y.fw     = sqrt(cosTheta1) .* y.sinTheta1 .* w;
end
y.theory = mode;
end

function y = opd(x, z, p)
z    = z + p.zShift;
ng   = p.n(2);
ngD  = p.nD(2);
tg   = p.d(2);
tgD  = p.dD(2);
OPDg = ng*tg*sqrt(1-x/ng^2) - ngD*tgD*sqrt(1-x/ngD^2);
ns   = p.n(3);
ts   = p.d(3);
OPDs = ns*ts*sqrt(1-x/ns^2);
ni   = p.n(1);
niD  = p.nD(1);
tiD  = p.dD(1);
ti   = ni *(-tg/ng + tgD/ngD + tiD/niD - ts/ns) + z;
OPDi = ni*ti*sqrt(1-x/ni^2) - niD*tiD*sqrt(1-x/niD^2);
y    = OPDg + OPDi + OPDs;
end