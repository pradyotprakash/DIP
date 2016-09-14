%% MyMainScript

tic;
%% Your code here
boat_struct = load('../data/boat');
boat = myLinearContrastStretching(boat_struct.imageOrig);
[corners, h, Ix, Iy, A, B, C] = myHarrisCornerDetector(boat, 0.7, 2, 0.03);
figure(1);
imshow(boat, []);
colorbar;
hold on;
[row, col] = find(corners);
plot(col, row, 'r*');

figure(2)
subplot(121)
imshow(Ix)
title('I_x: X Derivative of Image');
colorbar;

subplot(122)
imshow(Iy)
title('I_y: Y Derivative of Image');
colorbar;

[eig1, eig2] = myFindEigenValue(A,B,C);
figure(3)
subplot(121)
imshow(eig1)
colorbar;
title('EigenValue Images(I)');

subplot(122)
imshow(eig2)
title('EigenValue Images (II)');
colorbar;

figure(4)
imshow(h)
title('Cornerness Measure');
colorbar;
toc;