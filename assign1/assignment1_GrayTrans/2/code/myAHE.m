function [outputImage] = myAHE(inputImage, W)
	% Applies adaptive histogram equalization on inputImage with window size N 
	% and returns output Image
	funAHE = @(x) myAHEHelper(x);
	outputImage = nlfilter(inputImage, [W, W], funAHE);

	[M,N] = size(inputImage);
	for i = 1:M
		for j = 1:int64(W/2)
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myAHEHelper(subImg);
		end
	end

	for i = 1:M
		for j = N-int64(W/2):N
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myAHEHelper(subImg);
		end
	end

	for i = 1:int64(W/2)
		for j = 1:N
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myAHEHelper(subImg);
		end
	end

	for i = M-int64(W/2):M
		for j = 1:N
			subImg = inputImage(max(1, i-W):min(i+W, M), max(1, j-W):min(j+W, N));
			outputImage(i,j) = myAHEHelper(subImg);
		end
	end
end