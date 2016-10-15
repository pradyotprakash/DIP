figure;
for i = 1:100
	subplot(10, 10, i);
	imshow(reshape(A(:, i), [blockSize, blockSize]), []);
end