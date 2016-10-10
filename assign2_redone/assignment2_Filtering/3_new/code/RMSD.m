function dis = RMSD(img1, img2)
	v = img1 - img2;
	v = v .^ 2;

	dis = sqrt(mean2(v));
end