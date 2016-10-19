tic;
im =  double(imread('..\data\barbara256.png'));
Sigma = 20;
im1 = im + randn(size(im))*Sigma;
disp(strcat('Error from Source Image: ',' ',num2str(norm(im1-im,2))));
[im_PCA1] = myPCADenoising1(im1,Sigma);
[im_PCA2] = myPCADenoising2(im1,Sigma);
[im_Bilateral] = myBilateralFiltering(im1,5,1.5,9.7);
figure(1);
hold on;
subplot(1,3,1);
imshow(im,[0,255]);
title('Source Image');


subplot(1,3,2);
imshow(im1,[0,255]);
title('Noisy Image');

subplot(1,3,3); 
imshow(im_PCA1,[0,255]);
title('Final Image after Denoising (a)');
disp(strcat('Error from Source Image after Denoising (a): ',' ',num2str(norm(im_PCA1-im,2))));

figure(2);
hold on;
subplot(1,3,1);
imshow(im,[0,255]);
title('Source Image');

subplot(1,3,2);
imshow(im1,[0,255]);
title('Noisy Image');

subplot(1,3,3);
imshow(im_PCA2,[0,255]);
title('Final Image after Denoising (b)');
disp(strcat('Error from Source Image after Denoising (b): ',' ',num2str(norm(im_PCA2-im,2))));

figure(3);
hold on;
subplot(1,3,1);
imshow(im,[0,255]);
title('Source Image');

subplot(1,3,2);
imshow(im1,[0,255]);
title('Noisy Image');

subplot(1,3,3);
imshow(im_Bilateral,[0,255]);
title('Final Image after Denoising (c)');
disp(strcat('Error from Source Image after Denoising (c): ',' ',num2str(norm(im_Bilateral-im,2))));

toc;