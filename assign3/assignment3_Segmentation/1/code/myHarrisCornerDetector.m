function outputImage = myHarrisCornerDetection(inputImage, sigmaX, sigmaY, k)

	% assume inputImage in intensity range [0, 1]
	W = 5;

	[sizeX, sizeY] = size(inputImage);

	Ix = size(inputImage);
	Iy = size(inputImage);

	% compute Ix
	for i = 1:sizeX
		for j = 1:sizeY-1
			Ix(i, j) = inputImage(i, j+1) - inputImage(i, j);
		end
	end

	for i = 1:sizeX
		Ix(i, sizeY) = inputImage(i, sizeY) - inputImage(i, sizeY-1);
	end

	% compute Iy
	for i = 1:sizeX-1
		for j = 1:sizeY
			Iy(i, j) = inputImage(i+1, j) - inputImage(i, j);
		end
	end

	for j = 1:sizeY
		Iy(sizeX, j) = inputImage(sizeX, j) - inputImage(sizeX-1, j);
	end

	Ix2 = Ix .^ 2;
	Ixy = Ix .* Iy;
	Iy2 = iY .^ 2;

	hX = fspecial('gaussian', W, sigmaX);
	hX = fspecial('gaussian', W, sigmaY);
	h = hX .* hY;

	A = imfilter(Ix2, h);
	B = imfilter(Ixy, h);
	C = imfilter(Iy2, h);

	M1 = (A .* C) - b .^ 2;
	M2 = (A + C) .^ 2;
	H = M1 - k .* M2;

	corners = H > 0;
	
	outputImage = corners;
end