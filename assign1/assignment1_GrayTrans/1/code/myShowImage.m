function [] = myShowImage(InputImage)
	myNumOfColors = 256;
	myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
	% Shows Image with Colourbar and InputImage
	figure();
	colormap(myColorScale);
	imshow(InputImage,[]);
	axis on;
	colorbar;
end