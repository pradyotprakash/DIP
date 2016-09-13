%% MyMainScript

tic;
%% Your code here
lion_struct = load('../data/lionCrop');
lion = lion_struct.imageOrig;
enhanced_lion = myUnsharpMasking(lion, 9, 3, 2.0);
plotAndSave(lion, enhanced_lion, 'lion_enhanced', 1);

moon_struct = load('../data/superMoonCrop');
moon = moon_struct.imageOrig;
enhanced_moon = myUnsharpMasking(moon, 9, 3, 2.0);
plotAndSave(moon, enhanced_moon, 'moon_enhanced', 2);
toc;
