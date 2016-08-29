function [outputImage] = myLinearContrastStretching(inputImage)
	vec = inputImage(:);

	minVal = min(prctile(vec, 1));
	maxVal = max(prctile(vec, 99));

	t = max(minVal, min(maxVal, inputImage));

	g = @(x) (1.0 .* double(x - minVal) ./ double(maxVal - minVal));
	outputImage = g(t);
end