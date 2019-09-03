function [scale01, scaleOmega] = Pixel2Omega(uc, u, X, dXY)
if (mod(X, 2) ~= 0)
    error('X has to be even!');
end
uPx   = round(u *X*dXY);
ucPx  = round(uc*X*dXY);
uucPx = uPx + ucPx;
uScale01   =  uPx/X;
ucScale01  = ucPx/X;
uucScale01 = uScale01 + ucScale01;
mid        = 0.5 + 1/X;
if (uucScale01 >= mid)
    scale01    = [0, (mid - ucScale01), (mid -   uScale01), mid,...
                     (mid +   uScale01), (mid + ucScale01), 1]*X;
    scaleOmega = round([-X/2, -ucPx,  -uPx, 0,...
                                uPx,  ucPx, X/2-1]/ucPx, 1);
else
    scale01    = [0, (mid - uucScale01), (mid - ucScale01), (mid -   uScale01), mid,...
                     (mid +   uScale01), (mid + ucScale01), (mid + uucScale01), 1]*X;
    scaleOmega = round([-X/2, -uucPx, -ucPx,  -uPx, 0,...
                                 uPx,  ucPx, uucPx, X/2-1]/ucPx, 1);
end
end