tic;
N = 32; % Number of faces
nTraining = 6; % Training Images per face
nTotal = 10;

sourceFolderName = uigetdir();
listing = dir(sourceFolderName);
listingImage = dir(strcat(sourceFolderName, '/', listing(4).name));
n = listingImage(4).name;
x = imread(strcat(sourceFolderName, '/', listing(4).name, '/', n));
d = prod(size(x)); % Dimension of one image

X = zeros(d, N*nTraining);

disp('Collecting training data');
for i = 1:N
	listingImage = dir(strcat(sourceFolderName, '/', listing(i+3).name));
	for j = 1:nTraining
		n = listingImage(j+2).name;
		x = imread(strcat(sourceFolderName, '/', listing(i+3).name, '/', n));
		X(:, (i-1)*nTraining + j) = x(:);
	end
	disp(strcat('Collected images from ', int2str(i), 'th face'));
end

xMean = mean(X, 2);
X = bsxfun(@(x, y) x - y, X, xMean);
L = X'*X;

disp('Finding eigenvectors of X''X');
[V, D] = eig(L);   
[V, D] = sortEigenVectors(V, D);
% eigenvectors of C from V
eigenVectors = X*V; 

% Unit Normalise the eigenvectors
eigenVectors = normc(eigenVectors);
eigenCoefficients = eigenVectors'*X;

xTest = zeros(d, N*(nTotal - nTraining));
disp('Collecting test images');
listing = dir(sourceFolderName);
for i = 1:N
	listingImage = dir(strcat(sourceFolderName, '/', listing(i+3).name));
	for j = 1:(nTotal - nTraining)
		n = listingImage(j + 2 + nTraining).name;
		x = imread(strcat(sourceFolderName, '/', listing(i+3).name, '/', n));
		xTest(:, (i-1)*(nTotal - nTraining) + j) = x(:);
	end
	disp(strcat('Collected images from ', int2str(i), ' th face'));
end

xTest = bsxfun(@(x, y) x - y, xTest, xMean);
trainingEigenCoefficients = eigenVectors'*xTest;

K = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
KRecognitionRate = zeros(1, size(K, 2));

for j = 1:size(K, 2)
	k = K(j);

	% Pick the top k eigenvectors
	eigenCoefficients_k = eigenCoefficients(1:k, :);
	trainingEigenCoefficients_k = trainingEigenCoefficients(1:k, :);

	% Get eigenface of each image
	count = 0;
	for i = 1:size(xTest, 2)
		differences = repmat(trainingEigenCoefficients_k(:, i), 1, N*nTraining) - eigenCoefficients_k;
		[~, minImageIndex] =  min(sum(differences .^ 2));

		if floor((i-1)/(nTotal-nTraining)) == floor((minImageIndex-1)/(nTraining))
			count = count + 1;
		end
	end

	KRecognitionRate(j) = double(count)*100/size(xTest, 2);

end
figure(1);

plot(K, KRecognitionRate);
title('Recognition rate for different k (in %)');
xlabel('k');
ylabel('Recognition rate');

toc;