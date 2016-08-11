function [outputImage] = myCLAHE(inputImage, W, C)
	% Applies adaptive histogram equalization on inputImage with window size N 
	% and returns output Image
	funCLAHE = @(x) myCLAHEHelper(x, W);
	outputImage = nlfilter(inputImage, [W, W], funCLAHE);

	[M,N] = size(inputImage);
	for i = 1:M
		for j = 1:int64(W/2)
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myCLAHEHelper(subImg, C);
		end
	end

	for i = 1:M
		for j = N-int64(W/2):N
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myCLAHEHelper(subImg, C);
		end
	end

	for i = 1:int64(W/2)
		for j = 1:N
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myCLAHEHelper(subImg, C);
		end
	end

	for i = M-int64(W/2):M
		for j = 1:N
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myCLAHEHelper(subImg, C);
		end
	end
end