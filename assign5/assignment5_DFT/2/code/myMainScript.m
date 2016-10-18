tic;

load '../data/image_low_frequency_noise';

Y = zeros(512, 512);
Y(129:384, 129:384) = Z;

F2 = fftshift(fft2(Y));
F3 = F2;
F3(234:250, 238:255) = 0;
F3(270:290, 260:275) = 0;

I3 = real(ifft2(ifftshift(F3)));
I3 = I3(129:384, 129:384);

figure;
subplot(2, 2, 1);
imshow(log(1 + abs(F2)), []);
title('Log DFT');

subplot(2, 2, 2);
imshow(log(1 + abs(F3)), []);
title('Extra frequency components removed');

subplot(2, 2, 3);
imshow(Z, []);
title('Original noisy image');

subplot(2, 2, 4);
imshow(I3, []);
title('Restored image');

toc;