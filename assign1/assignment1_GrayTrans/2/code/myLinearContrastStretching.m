function [outputImage] = myLinearContrastStretching(inputImage)
	outputImage = zeros(sizeX, sizeY, 'uint8');
	minVal = min(min(inputImage));
	maxVal = max(max(inputImage));

	f = @(x) uint8(255.0 .* double(x - minVal) ./ double(maxVal - minVal));

	outputImage = f(inputImage);
end