function outputImage = myShrinkImageByFactorD(inputImage, d)
	% Take the file title and subsampling factor as the inputs and gives outputs the input image but subsampled by a factor of d
	% Detailed explanation goes here
    myGetBlockElement = @(x) x(1,1);
	g = @(block_struct) myGetBlockElement(block_struct.data);
	outputImage = blockproc(inputImage, [d, d], g);
end