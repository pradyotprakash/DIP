function [outputImage, noisyImage, err] = myPatchBasedFiltering(inputImage, patchSize, windowSize, sig1, sig2)

	minIntensity = min(min(inputImage));
	maxIntensity = max(max(inputImage));

	stdDev = 0.05 .* (maxIntensity - minIntensity);
	noise = stdDev .* randn(size(inputImage));
	noisyImage = inputImage + noise;

	[sizeX, sizeY] = size(inputImage);
	outputImage = zeros(size(inputImage));

	windowSizeHalf = floor(windowSize/2);
	patchSizeHalf = floor(patchSize/2);

	maskPatch = fspecial('gaussian', [9, 9], sig2);

	for i = 1:sizeX
		for j = 1:sizeY

			wxl = max(1, i - windowSizeHalf);
			wxr = min(sizeX, i + windowSizeHalf);
			wyl = max(1, j - windowSizeHalf);
			wyr = min(sizeY, j + windowSizeHalf);

			intensity = 0.0;
			weight = 0.0;

			for wx = wxl:wxr
				for wy = wyl:wyr

					pxl = max(1, wx - patchSizeHalf);
					pxr = min(sizeX, wx + patchSizeHalf);
					pyl = max(1, wy - patchSizeHalf);
					pyr = min(sizeY, wy + patchSizeHalf);

					similarity = 0.0;
					weig = 0.0;

					for px = pxl:pxr
						for py = pyl:pyr

							xDist = px - wx;
							yDist = py - wy;
							
							p = i + xDist;
							q = j + yDist;

							if p > 0 && p <= sizeX && q > 0 && q <= sizeY
								weig = weig + maskPatch(5 + xDist, 5 + yDist);
								similarity = similarity + maskPatch(5 + xDist, 5 + yDist)*(noisyImage(px, py) - noisyImage(p, q)) .^ 2;
							end
						end
					end

					similarity = similarity/weig;
					w = exp(-(similarity)/(2*(sig1^2)))/sqrt(2*pi*(sig1^2));
					intensity = intensity + w*noisyImage(wx, wy);
					weight = weight + w;
				end
			end
			outputImage(i, j) = intensity/weight;
		end
	end

	err = RMSD(inputImage, outputImage);

end