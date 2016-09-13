function [] = plotAndSave(img1, img2, name, i)
	figure(i);
	subplot(1, 2, 1);
	v = myLinearContrastStretching(img1);
	imshow(v, []);
	axis on;
	title('Original');

	subplot(1, 2, 2);
	v = myLinearContrastStretching(img2);
	imshow(v, []);
	axis on;
	title('Enhanced');

	saveas(i, strcat(name, '.png'));
end