tic;
rng(0);
im =  double(imread('../data/barbara256.png'));
Sigma = 20;
im1 = im + randn(size(im))*Sigma;
disp(strcat('Error from Source Image: ', ' ', num2str(RMSD(im, im1))));

im_PCA1 = myPCADenoising1(im1, Sigma);
figure(1);
hold on;
subplot(1, 3, 1);
imshow(im, []);
title('Source Image');

subplot(1, 3, 2);
imshow(im1, []);
title('Noisy Image');

subplot(1, 3, 3);
imshow(im_PCA1, []);
title('Final Image after Denoising (a)');
disp(strcat('Error from Source Image after Denoising (a): ', ' ', num2str(RMSD(im, im_PCA1))));

im_PCA2 = myPCADenoising2(im1, Sigma);
figure(2);
hold on;
subplot(1, 3, 1);
imshow(im, []);
title('Source Image');

subplot(1, 3, 2);
imshow(im1, []);
title('Noisy Image');

subplot(1, 3, 3);
imshow(im_PCA2, []);
title('Final Image after Denoising (b)');
disp(strcat('Error from Source Image after Denoising (b): ', ' ', num2str(RMSD(im, im_PCA2))));

im_Bilateral = myBilateralFiltering(im1, 5, 1.5, 9.7);
figure(3);
hold on;
subplot(1, 3, 1);
imshow(im, []);
title('Source Image');

subplot(1, 3, 2);
imshow(im1, []);
title('Noisy Image');

subplot(1, 3, 3);
imshow(im_Bilateral, []);
title('Final Image after Denoising (c)');
disp(strcat('Error from Source Image after Denoising (c): ', ' ', num2str(RMSD(im, im_Bilateral))));

toc;