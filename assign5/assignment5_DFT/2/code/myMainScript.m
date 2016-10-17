tic;

load '../data/image_low_frequency_noise';

F2 = fftshift(fft2(Z, 256, 256));
F3 = F2;
F3(115:125, 120:125) = 0;
F3(135:145, 133:138) = 0;

I3 = abs(ifft2(ifftshift(F3)));

figure;
subplot(2, 2, 1);
imshow(log(abs(F2)), []);
title('Log DFT');

subplot(2, 2, 2);
imshow(log(abs(F3)), []);
title('Extra frequency components removed');

subplot(2, 2, 3);
imshow(Z, []);
title('Original noisy image');

subplot(2, 2, 4);
imshow(I3, []);
title('Restored image');



toc;
