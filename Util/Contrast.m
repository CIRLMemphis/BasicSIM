function [ out ] = Contrast( data )
% by Hasti Shabani
[Maxima,MaxIdx] = findpeaks(data);
DataInv = max(data) - data;
[Minima,MinIdx] = findpeaks(DataInv);
Minima = data(MinIdx);
max_1 = mean(Maxima); min_1 = mean(Minima);
out = (max_1-min_1)/(max_1+min_1);
