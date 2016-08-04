function [ outputImage ] = myAHE( inputImage, N )
% Applies adaptive histogram equalization on inputImage with window size N 
% and returns output Image
funAHE = @(x)myAHEBlock(x(:));
outputImage =  nlfilter(inputImage,[N N],funAHE);

end

