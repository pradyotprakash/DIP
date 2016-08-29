function [] = plotAndSave(img1, img2, img3, name, i)
	f = figure(i);
	f.Name = name;
	title(name);
	subplot(1, 3, 1);
	v = myLinearContrastStretching(img1);
	imshow(v, []);
	axis on;
	title('Original');

	subplot(1, 3, 2);
	v = myLinearContrastStretching(img2);
	imshow(v, []);
	axis on;
	title('Noisy image');

	subplot(1, 3, 3);
	v = myNewLinearContrastStretching(img3);
	imshow(v, []);
	axis on;
	title('Bilaterial filtered image');

	saveas(i, strcat(name, '.png'));
end