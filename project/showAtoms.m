figure;
for i = 1:10
	fig = figure;
	for j = 1:10
		k = (i-1)*10 + j;
		subplot(2, 5, j);
		imshow(reshape(A(:, k), [blockSize, blockSize]), []);
	end
	saveas(fig, strcat('atoms/', num2str(i-1), '.png'));
end