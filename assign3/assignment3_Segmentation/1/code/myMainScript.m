%% MyMainScript

tic;
%% Your code here
boat_struct = load('../data/boat');
boat = myLinearContrastStretching(boat_struct.imageOrig);
[corners, h] = myHarrisCornerDetector(boat, 0.66, 1, 0.01);
imshow(boat, []);
hold on;
[row, col] = find(corners);
plot(row, col, 'r*');
toc;