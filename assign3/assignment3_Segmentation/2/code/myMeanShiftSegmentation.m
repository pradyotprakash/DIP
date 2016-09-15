function [outputImage] = myMeanShiftSegmentation(inputImage, numIterations, spaceSigma, intensitySigma)
	k = 400;

	indices = double(zeros(size(inputImage, 1)^2, 2));

	count = 0;
	for j = 1:size(inputImage, 1)
		for i = 1:size(inputImage, 1)
			count = count + 1;
			indices(count, :) = double([i, j]);
		end
	end

	imageRepresentation = double([indices, reshape(inputImage, [size(inputImage, 1)^2, 3])]);
	newImageRepresentation = double(zeros(size(imageRepresentation)));

	for iter = 1:numIterations
		iter
		f = bsxfun(@(x,y) x./y, imageRepresentation, sqrt(2)*[spaceSigma, spaceSigma, intensitySigma, intensitySigma, intensitySigma]);
		[IDX, D] = knnsearch(f, f, 'K', k);

		for count = 1:size(inputImage, 1)^2
				nbrs = imageRepresentation(IDX(count, 2:end), :);
				wts = exp(-((D(count, 2:end)).^2));
				u = sum(bsxfun(@(x,y) x.*y, nbrs, wts'));
				sum_wts = sum(wts);
				u = u/sum_wts;
				newImageRepresentation(count, :) = double([imageRepresentation(count, 1), imageRepresentation(count, 2), u(1, 3:end)]);
		end
		sum(sum(abs(imageRepresentation - newImageRepresentation)))/(size(imageRepresentation,1))
		imageRepresentation = newImageRepresentation;

	end
	outputImage = uint8(round(reshape(imageRepresentation(:, 3:5), [size(inputImage, 1), size(inputImage, 1), 3])));
end