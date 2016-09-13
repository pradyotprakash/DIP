%% MyMainScript

tic;
%% Your code here
baboon = imread('../data/baboonColor.png');
[scaled, output] = myMeanShiftSegmentation(baboon);
figure(1);
imshow(scaled);
title('Original scaled')
hold on;
figure(2);
imshow(output);
title('Mean shift segmented')
hold on;
toc;
