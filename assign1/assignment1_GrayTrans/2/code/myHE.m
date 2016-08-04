function [ outputImage ] = myHE( inputImage )
% myAHE takes the inputImage, 8 bit single channel image as the input and
% enhances it using Histogram equalisation

[sizeX, sizeY] = size(inputImage);
outputImage = zeros(sizeX,sizeY,'uint8');
ColorNumber = 256;
bins = zeros(ColorNumber,1);
cdf = zeros(ColorNumber,1);

for i = 1:sizeX
    for j = 1:sizeY
        bins(int32(inputImage(i,j))+1,1) = bins(int32(inputImage(i,j))+1,1) + 1;
    end
end

bins = bins / (sizeX*sizeY);
sum = 0;
for i = 1:ColorNumber
    sum = sum + bins(i);
    cdf(i,1) = sum;
end


bins = zeros(ColorNumber,1);
for i = 1:sizeX
    for j = 1:sizeY
        outputImage(i,j) = uint8(255.0*cdf(inputImage(i,j)+1)); 
        bins(outputImage(i,j)+1,1) = bins(outputImage(i,j)+1,1) + 1;
    end
end
end

