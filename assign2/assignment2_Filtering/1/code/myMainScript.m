%% MyMainScript

tic;
%% Your code here
lion_struct = load('../data/lionCrop');
lion = lion_struct.imageOrig;
enhanced = myUnsharpMasking(lion, 5, 10);
toc;
