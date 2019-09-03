function val = MemoryEstimation(X,Y,Z,Nphi,Nthe)
val = X*Y*Z*8/1000000/1000;
val = (val*Nphi*Nthe)*3 + val*2;
end