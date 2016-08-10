% Not sure what does the first and last row and columns contain same data mean? The size of the image has changed so this does not make any sense.

function outputImage = myBilinearInterpolation(inputImage)
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
			r = max(1, floor(rF));
			c = max(1, floor(cF));
			dR = rF - r;
			dC = cF - c;

			outputImage(rp,cp) = uint8(inputImage(r,c).*(1-dR).*(1-dC) + inputImage(r+1,c).*(dR).*(1-dC) + inputImage(r,c+1).*(1-dR).*(dC) + inputImage(r+1,c+1).*(dR).*(dC));
		end
    end
    
    
    
end