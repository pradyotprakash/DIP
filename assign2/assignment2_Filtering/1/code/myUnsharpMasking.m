function [outputImage] = myUnsharpMasking(inputImage, W, sig, lap_scale)
	inputImage = double(inputImage);

	h = fspecial('log', [W W], sig);
	LoG = imfilter(inputImage, h);
	outputImage = inputImage + lap_scale .* (inputImage - LoG);
end