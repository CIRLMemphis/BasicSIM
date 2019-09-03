% Given the lower and upper limits of integration x1 and x2, and given n, this routine returns
% arrays x[1..n] and w[1..n] of length n, containing the abscissas and weights of the Gauss-
% Legendre n-point quadrature formula.
function [x, w] = gaussl(x1, x2, n)
x = zeros(1,n);
w = zeros(1,n);
EPS = 3.0e-11; %EPS is the relative precision.
%double z1,z,xm,xl,pp,p3,p2,p1;
m = (n+1)/2; % The roots are symmetric in the interval, so we only have to find half of them.
xm = 0.5*(x2+x1);
xl = 0.5*(x2-x1);
for i = 1:m %Loop over the desired roots.
    z = cos(pi*(i-0.25)/(n+0.5));
    %Starting with the above approximation to the ith root, we enter the main loop of refinement by Newton’s method.
    p1 = 1.0; p2 = 0.0;
    for j=1:n %Loop up the recurrence relation to get the Legendre polynomial evaluated at z.
        p3 = p2; p2 = p1;
        p1 = ((2.0*j-1.0)*z*p2-(j-1.0)*p3)/j;
    end
    %p1 is now the desired Legendre polynomial. We next compute pp, its derivative,
    %by a standard relation involving also p2, the polynomial of one lower order.
    pp = n*(z*p1-p2)/(z*z-1.0);
    z1 = z;
    z = z1-p1/pp; % Newton’s method.
    while abs(z-z1) > EPS
        p1 = 1.0; p2 = 0.0;
        for j=1:n %Loop up the recurrence relation to get the Legendre polynomial evaluated at z.
            p3 = p2; p2 = p1;
            p1 = ((2.0*j-1.0)*z*p2-(j-1.0)*p3)/j;
        end
        %p1 is now the desired Legendre polynomial. We next compute pp, its derivative,
        %by a standard relation involving also p2, the polynomial of one lower order.
        pp = n*(z*p1-p2)/(z*z-1.0);
        z1 = z;
        z = z1-p1/pp; % Newton’s method.
    end
    x(i) = xm-xl*z;                   %Scale the root to the desired interval,
    x(n+1-i) = xm+xl*z;               %and put in its symmetric counterpart.
    w(i) = 2.0*xl/((1.0-z*z)*pp*pp);  %Compute the weight
    w(n+1-i) = w(i);                  %and its symmetric counterpart.
end
end
