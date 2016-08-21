function outputImage = myBilateralFiltering(inputImage, sigmaS, sigmaR)
	minIntensity = min(inputImage(:));
	maxIntensity = max(inputImage(:));

	stdDev = 0.05 .* (maxIntensity - minIntensity);
	noise = stdDev .* randn(size(inputImage));
	noisyImage = inputImage + noise;

	[sizeX, sizeY] = size(noisyImage);
	outputImage = noisyImage;

	W = 5;
	maskS = zeros(W, W);

	for i = -(W-1)/2:(W-1)/2
		for j = -(W-1)/2:(W-1)/2
			maskS(int32(W/2) + i, int32(W/2) + j) = exp(-0.5 .* (sqrt(i .^2 + j .^ 2))) ./ (sqrt(2 .* pi .* sigmaS .* sigmaS));
		end
	end

	for x = 1+int32(W/2):sizeX-int32(W/2)
		for y = 1+int32(W/2):sizeY-int32(W/2)
			v1 = 0.0;
			v2 = 0.0;
			
			for indi = -(W-1)/2:(W-1)/2
				for indj = -(W-1)/2:(W-1)/2
					v = maskS(int32(W/2) + indi, int32(W/2) + indj) .* exp(-0.5 .* (sqrt((inputImage(x, y) - inputImage(x+indi, y+indj)) .^2))) ./ (sqrt(2 .* pi .* sigmaR .* sigmaR));
					v1 = v1 + v;
					v2 = v2 + v.*inputImage(x+i, y+j);
				end
			end

			outputImage(x, y) = v2 ./ v1;
		end
	end

	% Shows Image with Colourbar and InputImage
	myNumOfColors = 256;
	myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
	
	figure;
	colormap(myColorScale);
	v = myLinearContrastStretching(imresize(maskS, [101, 101]));
	imshow(v, []);
	axis on;
	colorbar;
	title('Space mask');

	figure;
	subplot(1, 3, 1);
	colormap(myColorScale);
	v = myLinearContrastStretching(inputImage);
	imshow(v, []);
	axis on;
	colorbar;
	title('Original');

	subplot(1, 3, 2);
	colormap(myColorScale);
	v = myLinearContrastStretching(noisyImage);
	imshow(v, []);
	axis on;
	colorbar;
	title('Noisy image');

	subplot(1, 3, 3);
	colormap(myColorScale);
	v = myLinearContrastStretching(outputImage);
	imshow(v, []);
	axis on;
	colorbar;
	title('Bilaterial filtered image');
end