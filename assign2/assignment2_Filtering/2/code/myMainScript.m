%% MyMainScript

tic;
%% Your code here
barbara_struct = load('../data/barbara');
barbara = barbara_struct.imageOrig;
enhanced = myBilateralFiltering(barbara, 20, 20);
toc;