function outputImage = myNearestNeighborInterpolation(inputImage)
	[R,C] = size(inputImage);
	Rnew = 3*R - 2;
	Cnew = 2*C - 1;

	sR = R ./ Rnew;
	sC = C ./ Cnew;

	outputImage = zeros(Rnew, Cnew, 'uint8');

	for rp = 2:Rnew-1
		for cp = 2:Cnew-1
			rF = rp .* sR;
			cF = cp .* sC;
			r = max(2, floor(rF));
			c = max(2, floor(cF));

			outputImage(rp,cp) = uint8((inputImage(r-1,c-1) + inputImage(r-1,c) + inputImage(r-1,c+1) + inputImage(r,c-1) + inputImage(r,c+1) + inputImage(r,c) + inputImage(r+1,c-1) + inputImage(r+1,c) + inputImage(r+1,c+1))/9);
		end
	end
end