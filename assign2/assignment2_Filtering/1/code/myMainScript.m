%% MyMainScript

tic;
%% Your code here
lion_struct = load('../data/lionCrop');
lion = lion_struct.imageOrig;
enhanced_lion = myUnsharpMasking(lion, 12, 2, 4);

% moon_struct = load('../data/superMoonCrop');
% moon = moon_struct.imageOrig;
% enhanced_moon = myUnsharpMasking(moon, 12, 1.5, 1);
toc;
