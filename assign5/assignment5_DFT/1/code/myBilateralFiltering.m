function [outputImage, noisyImage] = myBilateralFiltering(noisyImage, W, sigmaS, sigmaR)
	[sizeX, sizeY] = size(noisyImage);
	outputImage = zeros(size(noisyImage));

	maskS = fspecial('gaussian', [W, W], sigmaS);
	half = floor(W/2);

	norm_consR = sqrt(2*pi) * sigmaR;
	for i = 1:sizeX
		for j = 1:sizeY

			% li = max(1, i-half); ri = min(sizeX, i+half);
			% ti = max(1, j-half); bi = min(sizeY, j+half);
			% bloc(li:ri, ti:bi) = noisyImage(li:ri, ti:bi) - noisyImage(i, j);
			% maskR = exp(-0.5 .* (bloc .^ 2)) ./ norm_consR;

			bloc = zeros(W, W);
			for x = -half:half
				for y = -half:half
					if i + x > 0 && i + x <= sizeX && j + y > 0 && j + y <= sizeY
						bloc(1+half+x, 1+half+y) = noisyImage(i + x, j + y);
						maskR(1+half+x, 1+half+y) = exp(((noisyImage(i + x, j + y) - noisyImage(i, j)) ^ 2) * (-0.5) / sigmaR^2) / norm_consR;
					else
						bloc(1+half+x, 1+half+y) = 0;
						maskR(1+half+x, 1+half+y) = 0;
					end
				end
			end
			
			mask = maskS .* maskR;
			num = sum(sum(bloc .* mask));
			den = sum(sum(mask));
			outputImage(i, j) = num/den;
		end
	end

end