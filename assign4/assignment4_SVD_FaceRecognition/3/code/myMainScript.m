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
threshold = 0.45;

X = zeros(d, N*nTraining);
faceMean = zeros(d, N);
faceRadius = zeros(1, N);

disp('Collecting training data');
for i = 1:N
	listingImage = dir(strcat(sourceFolderName, '/', listing(i+3).name));
	for j = 1:nTraining
		n = listingImage(j+2).name;
		x = double(imread(strcat(sourceFolderName, '/', listing(i+3).name, '/', n)));
		X(:, (i-1)*nTraining + j) = x(:);
	end
	disp(strcat('Collected images from ', int2str(i), 'th Face'));
end

xMean = mean(X, 2);
X = bsxfun(@(x, y) x - y, X, xMean);
L = X'*X;

disp('Finding eigenvectors of X''X');
[V, D] = eig(L);
[V, D] = sortEigenVectors(V, D);
% Find the eigenvectors of C from V
eigenVectors = X*V; 

% Unit Normalise the eigenvectors
eigenVectors = normc(eigenVectors);
eigenCoefficients = eigenVectors'*X;

for i = 1:N
	xTemp = X(1+(i-1)*nTraining:i*nTraining);
	faceMean(:, i) = mean(xTemp);
	distanceFromMean = bsxfun(@(x,y) sqrt(x-y).^2, xTemp, faceMean(:, i));
	faceRadius(1, i) = max(sum(distanceFromMean));
end

xTest = zeros(d, N*(nTotal - nTraining));
disp('Collectiong test images');
listing = dir(sourceFolderName);
for i = 1:N
	listingImage = dir(strcat(sourceFolderName, '/', listing(i+3).name));
	for j = 1:(nTotal-nTraining)
		n = listingImage(j+2+nTraining).name;
		x = imread(strcat(sourceFolderName, '/', listing(i+3).name, '/', n));
		xTest(:, (i-1)*(nTotal-nTraining) + j) = x(:);
	end
	disp(strcat('Collected images from ', int2str(i), ' th face'));
end

xTest = bsxfun(@(x, y) x - y, xTest, xMean);
trainingEigenCoefficients = eigenVectors'*xTest;

K = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
KRecognitionRate = zeros(1, size(K, 2));
KFalseNegative = zeros(1, size(K, 2));
KTrueNegative = zeros(1, size(K, 2));

for j = 1:size(K, 2)
	k = K(j);
	% Pick the top k eigenvectors
	eigenCoefficients_k = eigenCoefficients(1:k, :);
	trainingEigenCoefficients_k = trainingEigenCoefficients(1:k, :);

	% Get eigenface of each image
	count = 0;
	falseNeg = 0;
	for i = 1:size(xTest, 2)
		differences = repmat(trainingEigenCoefficients_k(:,i), 1, N*nTraining) - eigenCoefficients_k;
		[~, minImageIndex] = min(sum(differences.^2));

		radius = (trainingEigenCoefficients_k(:, i) - faceMean(1, floor((minImageIndex - 1)/nTraining) + 1)) .^ 2;
		radius = sqrt(sum(radius));
		
		if radius <= threshold*faceRadius(1, floor((minImageIndex-1)/nTraining)+1)
			if floor((i-1)/(10-nTraining)) == floor((minImageIndex-1)/(nTraining))
				count = count + 1;
			end
		else
			falseNeg = falseNeg + 1;
		end
	end
	KRecognitionRate(j) = double(count)*100/size(xTest, 2);
	KFalseNegative(j) = double(falseNeg)*100/size(xTest, 2);
end

disp('Collecting false test data');
listing = dir(sourceFolderName);
N1 = 8;
%%%
N1_training = 10;
xTest_false = zeros(d, N1*N1_training);

for i = N+1:N+N1
	listingImage = dir(strcat(sourceFolderName, '/', listing(i+2).name));
	for j = 1:N1_training
		n = listingImage(j+2).name;
		x = double(imread(strcat(sourceFolderName, '/', listing(i+2).name, '/', n)));
		xTest_false(:, (i-N-1)*(N1_training) + j) = x(:);
	end
end

xTest_false = bsxfun(@(x,y) x-y, xTest_false, xMean);
trainingEigenCoefficients_false = eigenVectors'*xTest_false;

for j = 1:size(K, 2)
	k = K(j);

	% Pick the top k eigenvectors
	eigenCoefficients_k = eigenCoefficients(1:k, :);
	trainingEigenCoefficients_false_k = trainingEigenCoefficients_false(1:k, :);
	
	% Get eigenface of each image
	true_neg = 0;
	for i = 1:size(xTest_false, 2)
		differences = repmat(trainingEigenCoefficients_false_k(:, i), 1, N*nTraining) - eigenCoefficients_k;
		[~, minImageIndex] = min(sum(differences.^2));

		radius = (trainingEigenCoefficients_false_k(:, i) - faceMean(1, floor((minImageIndex-1)/nTraining)+1)) .^ 2;
		radius = sum(sqrt(radius));
		if radius > threshold*double(faceRadius(1, floor((minImageIndex-1)/nTraining)+1))
			true_neg = true_neg + 1;
		end
	end
	KTrueNegative(j) = double(true_neg)*100/size(xTest_false, 2);
end

figure(1);
plot(K, KRecognitionRate);
title('Recognition Rate for different k (in %)');
xlabel('k');
ylabel('Recognition Rate');

figure(2);
plot(K, KFalseNegative);
title('False Negatives for different k (in %)');
xlabel('k');
ylabel('Recognition Rate');

figure(3);
plot(K, KTrueNegative);
title('True Negatives for different k (in %)');
xlabel('k');
ylabel('Recognition Rate');
toc;