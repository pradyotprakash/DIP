%% MyMainScript

tic;
%% Your code here
lion_struct = load('../data/lionCrop');
lion = lion_struct.imageOrig;
enhanced_lion = myUnsharpMasking(lion, 9, 0.6, 3.1);
plotAndSave(lion, enhanced_lion, 'lion_enhanced', 1);

moon_struct = load('../data/superMoonCrop');
moon = moon_struct.imageOrig;
enhanced_moon = myUnsharpMasking(moon, 9, 0.5, 8);
plotAndSave(moon, enhanced_moon, 'moon_enhanced', 2);
toc;
