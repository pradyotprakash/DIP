function [] = myPlotAndSave(img1, img2, name)
	i = 4343;
	figure(i);
	subplot(1, 2, 1);
	v = myLinearContrastStretching(img1);
	imshow(v, []);
	axis on;
	title('Original');

	subplot(1, 2, 2);
	v = myNewLinearContrastStretching(img2);
	imshow(v, []);
	axis on;
	title('Enhanced');

	saveas(i, strcat(name, '.png'));
end