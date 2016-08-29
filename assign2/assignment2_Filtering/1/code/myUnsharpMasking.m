function [outputImage] = myUnsharpMasking(inputImage, W, sig, lap_scale)
	inputImage = double(inputImage);

	h = fspecial('log', [W W], sig);
	LoG = imfilter(inputImage, h);
	outputImage = inputImage + lap_scale .* (inputImage - LoG);

	subplot(1, 2, 1);
	v = myLinearContrastStretching(inputImage);
	imshow(v, []);
	axis on;
	title('Original');

	subplot(1, 2, 2);
	v = myNewLinearContrastStretching(outputImage);
	imshow(v, []);
	axis on;
	title('Enhanced');
end