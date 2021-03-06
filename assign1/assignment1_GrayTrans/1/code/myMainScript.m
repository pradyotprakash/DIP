%% MyMainScript

tic;
im = imread('../data/circles_concentric.png');
outim_d2 = myShrinkImageByFactorD(im,2); % Generates im subsampled by Factor of 2
save('Concentric Circles, Subsampled by 2.mat','outim_d2');
myShowImage(outim_d2);

outim_d3 = myShrinkImageByFactorD(im,3); % Generates im subsampled by Factor of 2
save('Concentric Circles, Subsampled by 3.mat','outim_d3');
myShowImage(outim_d3);

im1 =  imread('../data/barbaraSmall.png');
out_bilinear = myBilinearInterpolation(im1);
out_nearest_neighbour = myNearestNeighborInterpolation(im1);
save('barbaraSmall_BilinearInterpolation','out_bilinear');
save('barbaraSmall_NearestNeighbour','out_nearest_neighbour');
axis square
myShowImage(im1);
myNumOfColors = 256;
myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
figure()
colormap(myColorScale);
image(out_bilinear);
axis on
colorbar

figure()
colormap(myColorScale);
image(out_nearest_neighbour);
axis on
colorbar


toc;