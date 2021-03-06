function [outputImage, H, Ix, Iy, A,B,C] = myHarrisCornerDetection(inputImage, sigma1, sigma2, k)

	W = 5;

	h = fspecial('gaussian', [2, 2], sigma1);
	inputImage = imfilter(inputImage, h);
    FilterX = [-1 0 1;-2 0 2;-1 0 1];
    FilterY = FilterX';
    Ix = imfilter(inputImage,FilterX);
    Iy = imfilter(inputImage,FilterY);

	

	Ix2 = Ix .^ 2;
	Ixy = Ix .* Iy;
	Iy2 = Iy .^ 2;

	h = fspecial('gaussian', [W, W], sigma2);

	A = imfilter(Ix2, h);
	B = imfilter(Ixy, h);
	C = imfilter(Iy2, h);

	M1 = (A .* C) - B .^ 2;
	M2 = (A + C) .^ 2;
	H = M1 - (k * M2);

	% imregional max used for non-maximal supression and the product for the cornerness measure
	corners = imregionalmax(H) .* (H > 0.1);
	outputImage = corners;
end