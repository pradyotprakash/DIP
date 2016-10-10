tic;

blockSize = 5;
half = floor(blockSize/2); % 2
trainData = 'MNIST_extracted/train_images/';

for label = 0:0

	count = 0;
	sourceFolder = strcat(trainData, int2str(label), '/');
	listing = dir(sourceFolder);
	temp = zeros(blockSize^2, 576*(size(listing, 1)-2), 'single');

	for i = 3:size(listing, 1) - 2
		img = imread(strcat(sourceFolder, listing(i).name));

		for x = half:size(img, 1) - half-1
			for y = half:size(img, 2) - half-1
				p = x - half+1;
				q = y - half+1;
				t = img(p:p+blockSize-1, q:q+blockSize-1);

				if nnz(t) > 10
					count = count + 1;
					temp(:, count) = normc(single(t(:)));
				end
			end
		end
	end

end

X = temp(:, 1:count);
clear temp trainData label count sourceFolder listing img x y p q t;

toc;