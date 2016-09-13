%% MyMainScript

tic;
%% Your code here
baboon = imread('../data/baboonColor.png');
t = myMeanShiftSegmentation(baboon);
% inputImage = baboon;
% myMeanShiftSegmentation;
toc;
