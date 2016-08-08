function [outputImage] = myHE(inputImage)
	% myHE takes the inputImage, 8 bit single channel image as the input and
	% enhances it using Histogram equalisation

	[sizeX, sizeY] = size(inputImage);
	outputImage = zeros(sizeX, sizeY, 'uint8');
	ColorNumber = 256;
	bins = zeros(ColorNumber, 1);
	vcdf = zeros(ColorNumber, 1);

	vec = [inputImage(:);(0:255)'];
	uniq = (0:255)';
	t = [uniq, histc(vec, uniq)];
	bins = t(:,2) - 1;

	bins = bins ./ (sizeX*sizeY);
	sum = 0;

	for i = 1:ColorNumber
		sum = sum + bins(i);
		vcdf(i,1) = sum;
	end

	for i = 1:sizeX
		for j = 1:sizeY
			outputImage(i,j) = uint8(255.0*vcdf(inputImage(i,j)+1));
		end
	end
end

