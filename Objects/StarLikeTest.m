N  = 128;
ob = StarLikeSample(3,N,8,20,3,0.7);
X = N;
Y = N;
Z = N;
xvec = [];
yvec = [];
zvec = [];
fvec = [];
[xx,yy,zz] = meshgrid(1:X, 1:Y, 1:Z);
for xi = 1:X
    for yi = 1:Y
        for zi = 1:Z
            xxi = xx(xi,yi,zi);
            yyi = yy(xi,yi,zi);
            zzi = zz(xi,yi,zi);
            if (ob(xi,yi,zi) > 0.4)
                xvec(end+1) = xxi;
                yvec(end+1) = yyi;
                zvec(end+1) = zzi;
                fvec(end+1) = ob(xi,yi,zi);
            end
        end
    end
end

%%
figure;
scatter3(xvec, yvec, zvec, [], fvec, 'filled'); colorbar;
%xlim([min(x) max(x)]); ylim([min(x) max(x)]); zlim([min(z) max(z)]);
xlabel('x'); ylabel('y'); zlabel('z');