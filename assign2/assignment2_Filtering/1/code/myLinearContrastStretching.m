function [outputImage] = myLinearContrastStretching(inputImage)
	[sizeX, sizeY] = size(inputImage);
    outputImage = zeros(sizeX, sizeY);
	minVal = min(min(inputImage));
	maxVal = max(max(inputImage));

	f = @(x) (1.0 .* double(x - minVal) ./ double(maxVal - minVal));

	outputImage = f(inputImage);
end