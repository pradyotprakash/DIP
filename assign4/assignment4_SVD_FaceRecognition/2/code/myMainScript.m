tic;
N = 38; % Number of faces
nTraining = 40; % Training Images per face

sourceFolderName = uigetdir();
listing = dir(sourceFolderName);
listingImage = dir(strcat(sourceFolderName, '/', listing(4).name));
n = listingImage(4).name;
x = imread(strcat(sourceFolderName, '/', listing(4).name, '/', n));
[sizeX, sizeY] = size(x);
d = prod(size(x)); % Dimension of one image

X = zeros(d, N*nTraining);
listing = dir(sourceFolderName);
for i = 1:N
	listingImage = dir(strcat(sourceFolderName, '/', listing(i+2).name));
	for j = 1:nTraining
		n = listingImage(j+2).name;
		x = imread(strcat(sourceFolderName, '/', listing(i+2).name, '/', n));
		X(:, (i-1)*nTraining + j) = x(:);
	end
	disp(strcat('Collected images from ', int2str(i), ' th face'));
end

xMean = mean(X, 2);
X = bsxfun(@(x, y) x - y, X, xMean);
L = X'*X;

disp('Finding eigenvectors of X''X');
[V, D] = eig(L);	
[V, D] = sortEigenVectors(V, D);
% Find the eigenvectors of C from V
eigenVectors = X*V;

% Unit normalise the eigenvectors
eigenVectors = normc(eigenVectors);
eigenCoefficients = eigenVectors'*X;

K = [2, 10, 20, 50, 75, 100, 125, 150, 175];

i = 3;
disp('Doing the reconstruction for image i = 3');
figure(1);
title('Eigenvalue approximation for test image (with increasing k'); 
for j = 1:size(K, 2)
	k = K(j);
	% Pick the top k eigenvectors' Components
	eigenCoefficients_k = eigenCoefficients(1:k, :);
	eigenVectors_k = eigenVectors(:, 1:k);

	XImage_k = eigenCoefficients_k(:, i);
	XImage = eigenVectors_k*XImage_k;
	XImage = XImage + xMean;
	subplot(2, 5, j);
	imshow(uint8(reshape(XImage, sizeX, sizeY)));
end
% show the original image
subplot(2, 5, 10);
imshow(uint8(reshape(X(:, i) + xMean, sizeX, sizeY)));

% plot the eigenfaces
figure(2);
for k = 1:25
	subplot(5, 5, k);
	imshow(reshape(eigenVectors(:, k), sizeX, sizeY), []);
end
toc;