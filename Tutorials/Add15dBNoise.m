function [outData, SNR] = Add15dBNoise(inData)
b        = 0.0168; % 1.5% of the signal is background
scaleCCA = 2980;
[outData, SNR] = AddPoissnNoise(inData, b, scaleCCA);
end

