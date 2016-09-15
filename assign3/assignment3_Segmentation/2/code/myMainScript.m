%% MyMainScript

tic;
%% Your code here
baboon = double(imread('../data/baboonColor.png'));
scalingFactor = 4;
inputImage = double(zeros(size(baboon, 1)/scalingFactor, size(baboon, 2)/scalingFactor, 3));
h = fspecial('gaussian', [2, 2], 0.66);
for i = 1:3
	inputImage(:, :, i) = myShrinkImageByFactorD(imfilter(baboon(:, :, i), h), scalingFactor);
end

numIterations = 20;
spaceSigma = 16;
intensitySigma = 25;

outputImage = myMeanShiftSegmentation(inputImage, numIterations, spaceSigma, intensitySigma);
figure;
subplot(1, 2, 1);
imshow(uint8(inputImage));
hold on;
subplot(1, 2, 2);
imshow(outputImage);
hold on;
toc;
