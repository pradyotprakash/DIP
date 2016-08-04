function [outputValue] = myCLAHEHelper(inputImage, C)
	% myAHE takes the inputImage, 8 bit single channel image as the input and
	% enhances it using Histogram equalisation

	[sizeX, sizeY] = size(inputImage);
	ColorNumber = 256;
	bins = zeros(ColorNumber, 1);
	cdf = zeros(ColorNumber, 1);

	for i = 1:sizeX
		for j = 1:sizeY
			bins(int32(inputImage(i,j))+1, 1) = bins(int32(inputImage(i,j))+1, 1) + 1;
		end
	end

	C = C * sizeX * sizeY;
	points = 0;
	for i = 1:ColorNumber
		if bins(i) > C
			points = points + (bins(i) - C);
			bins(i) = C;
		end
	end

	points = points ./ ColorNumber;
	bins = (bins + points) ./ (sizeX * sizeY);

	sum = 0;
	for i = 1:ColorNumber
		sum = sum + bins(i);
		cdf(i,1) = sum;
	end

	outputValue = uint8(255.0*cdf(inputImage(int32(sizeX/2), int32(sizeY/2))+1));
end