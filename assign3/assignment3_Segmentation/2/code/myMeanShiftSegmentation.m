function [processedImage, outputImage] = myMeanShiftSegmentation(inputImage)

	W = 2;
	sigma1 = 0.66;
	numIterations = 20;
	spaceSigma = 20;
	intensitySigma = 20;

	sigmas = -2 .* ([spaceSigma, spaceSigma, intensitySigma, intensitySigma, intensitySigma] .^ 2);
	sigmaProds = (2*pi)^2.5 * spaceSigma * spaceSigma * intensitySigma * intensitySigma * intensitySigma;

	k = 1 + 100;

	h = fspecial('gaussian', [W, W], sigma1);

	for i = 1:3
		processedImage(:, :, i) = myShrinkImageByFactorD(imfilter(myLinearContrastStretching(inputImage(:, :, i)), h), 2);
	end

	numPixels = size(processedImage, 1) * size(processedImage, 2);
	imageRepresentation = zeros(numPixels, 5);
	newImageRepresentation = zeros(size(imageRepresentation));

	% initialize imageRepresentation
	count = 0;
	for x = 1:size(processedImage, 1)
		for y = 1:size(processedImage, 2)
			count = count + 1;
			imageRepresentation(count, :) = [x/255, y/255, processedImage(x, y, 1), processedImage(x, y, 2), processedImage(x, y, 3)];
		end
	end

	for i = 1:numIterations
		fprintf('Iter: %d\n', i);
		[IDX, D] = knnsearch(imageRepresentation, imageRepresentation, 'K', k, 'IncludeTies', ~true); %handle cell situation later

		for x = 1:size(processedImage, 1)
			for y = 1:size(processedImage, 2)
				rowInRepresentationMatrix = (x-1) * size(processedImage, 2) + y;

				points = IDX(rowInRepresentationMatrix, 2:end); % k-1 closest points here
				currentPoint = imageRepresentation(rowInRepresentationMatrix, :);

				u = zeros(1, 5);
				w = 0;

				for t = 1:size(points, 2)
					point = imageRepresentation(points(1, t), :);
					w1 = exp(sum(((currentPoint - point).^2) ./ sigmas))/ sigmaProds;

					u = u + w1*point;
					w = w + w1;
				end

				u = u./w;
						newImageRepresentation(rowInRepresentationMatrix, :) = [currentPoint(1, 1),  currentPoint(1, 2), u(1, 3), u(1, 4), u(1, 5)];

			end
		end	

		imageRepresentation = newImageRepresentation;
	end

	% row = zeros(numPixels, 1);
	% col = zeros(numPixels, 1);
	% for i = 1:size(imageRepresentation, 1)
	% 	row(i, 1) = imageRepresentation(i, 1);
	% 	col(i, 1) = imageRepresentation(i, 2);
	% end
	% 
	% figure;
	% plot(row, col, 'r*');
	% hold on;

	outputImage = zeros(size(processedImage));
	for x = 1:size(processedImage, 1)
		for y = 1:size(processedImage, 2)
			rowInRepresentationMatrix = (x-1) * size(processedImage, 2) + y;
			for i = 1:3
				outputImage(x,y,i) = imageRepresentation(rowInRepresentationMatrix, i+2);
			end
		end
	end

end