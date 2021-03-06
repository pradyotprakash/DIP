%% MyMainScript
tic;
%% Your code here
W = 5; % should always be odd, can't be even

barbara_struct = load('../data/barbara');
barbara = barbara_struct.imageOrig;

sigmaS = 1.5;
sigmaR = 9.7;
[enhanced, noisy, err] = myBilateralFiltering(barbara, W, sigmaS, sigmaR);
plotAndSave(barbara, noisy, enhanced, 'optimal', 1);
fprintf('optimal: dist: %d\n', err);

[enhanced, noisy, err] = myBilateralFiltering(barbara, W, 0.9*sigmaS, sigmaR);
plotAndSave(barbara, noisy, enhanced, '9space', 2);
fprintf('0.9 space: dist: %d\n', err);

[enhanced, noisy, err] = myBilateralFiltering(barbara, W, 1.1*sigmaS, sigmaR);
plotAndSave(barbara, noisy, enhanced, '11space', 3);
fprintf('1.1 space: dist: %d\n', err);

[enhanced, noisy, err] = myBilateralFiltering(barbara, W, sigmaS, 0.9*sigmaR);
plotAndSave(barbara, noisy, enhanced, '9range', 4);
fprintf('0.9 range: dist: %d\n', err);

[enhanced, noisy, err] = myBilateralFiltering(barbara, W, sigmaS, 1.1*sigmaR);
plotAndSave(barbara, noisy, enhanced, '11range', 5);
fprintf('1.1 range: dist: %d\n', err);

maskS = fspecial('gaussian', [W, W], sigmaS);
figure(10000);
v = myLinearContrastStretching(maskS);
imshow(v, []);
axis on;
title('gaussian along space');
saveas(10000, 'space_gaussian.png');
toc;