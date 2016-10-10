tic;

barbara = load('../data/barbara');
barbara = barbara.imageOrig;

h = fspecial('gaussian', [2, 2], 0.66);
inputImage = imfilter(barbara, h);
inputImage = imresize(inputImage, 0.5);

patchSize = 9;
windowSize = 25;
sig1 = 3.7;
sig2 = 2.2;

[outputImage, noisyImage, err] = myPatchBasedFiltering(inputImage, 9, 25, sig1, sig2);
plotAndSave(inputImage, noisyImage, outputImage, 'optimal', 1);
fprintf('optimal: dist: %d\n', err);

[outputImage, noisyImage, err] = myPatchBasedFiltering(inputImage, 9, 25, 0.9*sig1, sig2);
plotAndSave(inputImage, noisyImage, outputImage, '9sig', 2);
fprintf('0.9 sig: dist: %d\n', err);

[outputImage, noisyImage, err] = myPatchBasedFiltering(inputImage, 9, 25, 1.1*sig1, sig2);
plotAndSave(inputImage, noisyImage, outputImage, '11sig', 3);
fprintf('1.1 sig: dist: %d\n', err);

% best1 = 0;
% best2 = 0;
% bestImage = [];
% minErr = 10^6;

% for sig1 = 1:10
% 	for sig2 = 1:10
% 		fprintf('%f %f\n', sig1, sig2);
% 		[outputImage, noisyImage, err] = myPatchBasedFiltering(inputImage, 9, 25, sig1, sig2);
% 		if err < minErr
% 			minErr = err;
% 			best1 = sig1;
% 			best2 = sig2;
% 			bestImage = outputImage;
% 		end
% 	end
% end

toc;