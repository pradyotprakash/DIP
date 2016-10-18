tic;

I1 = imread('../data/barbara256.png');
I2 = zeros(512, 512);
I2(129:384, 129:384) = I1;

F2 = fftshift(fft2(I2));

for D = [40, 80]
	center = [256; 256];

	[X, Y] = meshgrid(1:512);
	C = sqrt((X - center(1)) .^ 2 + (Y - center(2)) .^ 2) <= D;

	F3 = F2 .* C;
	T = real(ifft2(ifftshift(F3)));
	T = T(129:384, 129:384);
	fig = figure;
	subplot(1, 2, 1);
	imshow(log(1 + abs(F3)), []);
	subplot(1, 2, 2);
	imshow(T, []);
	saveas(fig, strcat('../images/idealLowPass_', num2str(D), '.png'));
end

for sig = [40, 80]
	h = fspecial('gaussian', [512 512], sig);
	F3 = F2 .* h;
	T = real(ifft2(ifftshift(F3)));
	T = T(129:384, 129:384);
	fig = figure;
	subplot(1, 2, 1);
	imshow(log(1 + abs(F3)), []);
	subplot(1, 2, 2);
	imshow(T, []);
	saveas(fig, strcat('../images/gaussianLowPass_', num2str(sig), '.png'));
end

toc;
