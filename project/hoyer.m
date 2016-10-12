tic;

blockSize = 5;
lambda = 10;
numAtoms = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10];
c = 0;
A = zeros(blockSize^2, sum(numAtoms));
X = [];
labels = [];

fprintf('Starting computing atoms\n');

for label = 0:9
	m = numAtoms(1, label + 1);
	[Ai, Xi] = getAtoms(label, m, blockSize, lambda);
	A(:, c + 1:c + m) = Ai;
	c = c + m;
	X = [X, Xi];
	labels = [labels, ones(1, size(Xi, 2)) * label];
	clear Ai Xi;
end

fprintf('All atoms computed\n');
fprintf('Sparse coding the data\n');

S = learnCodes(X, A, lambda);
clear X;
fprintf('Convergence for S complete\n');

fprintf('Fitting random forest classifier\n');
Mdl = TreeBagger(50, S', labels', 'oobpred', 'on', 'Method', 'classification');

% validations
fprintf('Starting validation\n');
for label = 0:9
	acc = validate(Mdl, label, A, blockSize, lambda);
	fprintf('Accuracy for class %d: %f\n', label, acc);
end

toc;