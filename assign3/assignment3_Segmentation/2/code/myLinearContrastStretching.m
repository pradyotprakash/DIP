function [outputImage] = myLinearContrastStretching(inputImage)
	vec = inputImage(:);
	minVal = min(vec);
	maxVal = max(vec);

	g = @(x) (1.0 .* double(x - minVal) ./ double(maxVal - minVal));
	outputImage = g(inputImage);
end