function [outputImage] = myUnsharpMasking(inputImage, W, sig)
	h = fspecial('log', [W W], sig);
	LoG = imfilter(inputImage, h);
	smoothenedImage = imsubtract(inputImage, LoG);
	outputImage = imadd(inputImage, smoothenedImage);

	% Shows Image with Colourbar and InputImage
	myNumOfColors = 256;
	myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
	
	subplot(1, 2, 1);
	colormap(myColorScale);
	v = myLinearContrastStretching(inputImage);
	imshow(v, []);
	axis on;
	colorbar;
	title('Original');

	subplot(1, 2, 2);
	colormap(myColorScale);
	v = myLinearContrastStretching(outputImage);
	imshow(v, []);
	axis on;
	colorbar;
	title('Enhanced');
end