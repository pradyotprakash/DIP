function [outputImage] = myCLAHE(inputImage, N, C)
	% Applies adaptive histogram equalization on inputImage with window size N 
	% and returns output Image
	funCLAHE = @(x) myCLAHEHelper(x, C);
	outputImage = nlfilter(inputImage, [N, N], funCLAHE);
end