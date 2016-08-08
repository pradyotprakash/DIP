function [outputValue] = myAHEHelper(inputImage)
	% myAHE takes the inputImage, 8 bit single channel image as the input and
	% enhances it using Histogram equalisation

	[sizeX, sizeY] = size(inputImage);
	ColorNumber = 256;
	bins = zeros(ColorNumber, 1);
	cdf = zeros(ColorNumber, 1);

	vec = [inputImage(:);(0:255)'];
	uniq = (0:255)';
	t = [uniq, histc(vec, uniq)];
	bins = t(:,2) - 1;

	bins = bins ./ (sizeX*sizeY);
	sum = 0;

	for i = 1:ColorNumber
		sum = sum + bins(i);
		cdf(i,1) = sum;
	end

	outputValue = uint8(255.0*cdf(inputImage(int32(sizeX/2), int32(sizeY/2))+1));
end