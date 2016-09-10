%% MyMainScript

tic;
%% Your code here
boat_struct = load('../data/boat');
boat = myLinearContrastStretching(boat_struct.imageOrig);
corner_boat = myHarrisCornerDetection(boat, 9, 0.6, 3.1);
toc;