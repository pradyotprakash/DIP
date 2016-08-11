function outputImage = myNearestNeighborInterpolation(inputImage)
	[R,C] = size(inputImage);
	Rnew = 3*R - 2;
	Cnew = 2*C - 1;

	sR = R ./ Rnew;
	sC = C ./ Cnew;

	outputImage = zeros(Rnew, Cnew);

	for rp = 2:Rnew-1
		for cp = 2:Cnew-1
			rF = rp .* sR;
			cF = cp .* sC;
			r = max(1, floor(rF));
			c = max(1, floor(cF));

			outputImage(rp,cp) = inputImage(r,c);
		end
	end
end