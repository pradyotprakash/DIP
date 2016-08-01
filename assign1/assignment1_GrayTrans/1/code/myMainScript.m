%% MyMainScript

tic;
%% Your code here
% Change FolderPath to the current location of assignmen1_GrayTrans
FolderPath = 'C:\Users\Yash Sanghvi\Dropbox\Semester VII\Digital Image Processing CS663\Assignment_1\assignment1_GrayTrans';
myNumOfColors = 256;
myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];


im = imread([FolderPath, '\1\data\circles_concentric.png']);
out1_d2 = myShrinkImageByFactorD(im,2); % Generates im subsampled by Factor of 2
out1_d3 = myShrinkImageByFactorD(im,3); % Generates im subsampled by Factor of 3

myShowImage(im);
myShowImage(out1_d2);
myShowImage(out1_d3);
toc;
