%% MyMainScript

tic;
%% Your code here
im = load('..\data\barbara');
src = 2*im.imageOrig;
% src_shrink = myShrinkImageByFactorD(src,2);
src_shrink = src;
% Calculate the Standard Deviation of the image
Sigma = 0.05*(max(max(src_shrink))-min(min(src_shrink)));
[sizeX, sizeY] = size(src);
noise = Sigma*randn([sizeX,sizeY]);
Corrupted = src + noise;
% Corrupted_shrink = myShrinkImageByFactorD(Corrupted,2);
Corrupted_shrink = Corrupted;
% myShowImage(uint8(src));
% title('Original Image');

% myShowImage(uint8(Corrupted));
% title('Corrupted Image');
% Intial RMSD between original and corrupted image
% PRevious 7, 3

G = fspecial('gaussian',2,0.66);
Corrupted_shrink = imfilter(Corrupted_shrink,G,'replicate');
Inital_RMSD = myRMSD(src_shrink,Corrupted_shrink)
BilateralFilter_Shrink = myPatchBasedFiltering(Corrupted_shrink, 12, 4, 1.08);
myShowImage(uint8(src));
title('Source Image');

Final_RMS = myRMSD(src_shrink,BilateralFilter_Shrink)
% BilateralFilter = myBilinearInterpolation(BilateralFilter_Shrink,sizeX,sizeY);
myShowImage(uint8(BilateralFilter_Shrink));
title('Corrected Image');

toc;
