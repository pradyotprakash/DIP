function [OutputImage] = myShrinkImageByFactorD(InputImage, d)
	% Take the file title and subsampling factor as the inputs and gives outputs the input image but subsampled by a factor of d
	% Detailed explanation goes here
    myGetBlockElement = @(X) X(1,1);
	fun = @(block_struct) myGetBlockElement(block_struct.data);
	OutputImage = blockproc(InputImage, [d, d], fun, 'UseParallel', 1);
end