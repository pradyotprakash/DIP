function [X] = prepareData(label, blockSize, name)

	trainData = strcat('MNIST_extracted/', name, '_images/');

	count = 0;
	sourceFolder = strcat(trainData, int2str(label), '/');
	listing = dir(sourceFolder);

	X = zeros(blockSize^2, size(listing, 1) - 2, 'single');

	for i = 3:size(listing, 1)
		img = imread(strcat(sourceFolder, listing(i).name));
		h = fspecial('gaussian', 2, 0.66);
		img = imfilter(img, h);
		img = imresize(img, [blockSize, blockSize]);
		count = count + 1;
		X(:, count) = normc(single(img(:)));
	end

	clear trainData label count sourceFolder listing img x y p q t temp;

end