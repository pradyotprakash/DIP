%% MyMainScript

tic;
%% Your code here
lion_struct = load('../data/lionCrop');
lion = lion_struct.imageOrig;
enhanced = myBilateralFiltering(lion, 1, 1);
toc;
