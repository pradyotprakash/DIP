function [err] = RMSD(img1, img2)
	err = sqrt(mean2((img1 - img2) .^ 2));
end