function [] = myShowImage(img)
	myNumOfColors = 256;
	myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

	% Shows Image with Colourbar and InputImage
	figure();
	colormap(myColorScale);
	v = myLinearContrastStretching(img);
	imshow(v, []);
	axis on;
	colorbar;
end