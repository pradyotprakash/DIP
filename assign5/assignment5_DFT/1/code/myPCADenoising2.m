function [im_Final] = myPCADenoising2(im1, Sigma)

	[sizeX, sizeY] = size(im1);
	N = 3;
	L = 15;
	K = 200;

	sizeP_X = sizeX - 2*N;
	sizeP_Y = sizeY - 2*N;
	P = zeros((2*N + 1)*(2*N + 1), sizeP_X*sizeP_Y);
	P_Final = zeros(size(P));

	disp('Forming Patch Vector P and Corresponding Similar Patch Vector Q');
	for i = 1:sizeP_X
		for j = 1:sizeP_Y
			im1Patch = im1(i:i + 2*N, j:j + 2*N);
			im1Patch_Col = im1Patch(:);
			[Q_i, n1] = FindQi(im1, im1Patch_Col, i, j, N, L, K);

			[V, ~] = eig(Q_i * Q_i');
			V = normc(V);

			EigenCoeff_Patch = V' * Q_i;
			AvgSquared_EigenCoeff = max(0, (sum(EigenCoeff_Patch .^ 2, 2)/n1) - (Sigma^2)*ones((2*N +1)^2, 1));
			Multiplication_Matrix = (AvgSquared_EigenCoeff) ./ (Sigma^2 + AvgSquared_EigenCoeff);

			something = V' * im1Patch_Col;
			EigenCoeff_Patch_Denoised = something .* Multiplication_Matrix;
			P_Final(:, (i-1)*sizeP_X + j) = V*EigenCoeff_Patch_Denoised;
		end
	end

	im_Final = zeros(size(im1));
	Pixel_Count = zeros(size(im1));
	disp('Reassembling Patch Vector to form Final Image');

	for i = 1:sizeP_X
		for j = 1:sizeP_Y
			Im_Patch_Col = P_Final(:, (i-1)*sizeP_X + j);
			Im_Patch = reshape(Im_Patch_Col, [2*N + 1, 2*N + 1]);
			im_Final(i:i + 2*N, j:j + 2*N) = im_Final(i:i + 2*N, j:j + 2*N) + Im_Patch;
			Pixel_Count(i:i + 2*N, j:j + 2*N) = Pixel_Count(i:i + 2*N, j:j + 2*N) + 1; 
		end
	end

	im_Final = im_Final ./ Pixel_Count;
end