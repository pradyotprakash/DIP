%% MyMainScript

tic;
im = imread('../data/circles_concentric.png');
% outim_d2 = myShrinkImageByFactorD(im,2); % Generates im subsampled by Factor of 2
% outim_d3 = myShrinkImageByFactorD(im,3); % Generates im subsampled by Factor of 3
% out_bilinear = myBilinearInterpolation(im);
out_nn = myNearestNeighborInterpolation(im);
myShowImage(im);
% myShowImage(outim_d2);
% myShowImage(outim_d3);
% myShowImage(out_bilinear);
myShowImage(out_nn);
toc;