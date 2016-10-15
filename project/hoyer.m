tic;

blockSize = 14;
lambda = 0;
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

% Mdl = fitcdiscr(S', labels);
% Mdl = fitcdiscr(S', labels, 'DiscrimType', 'quadratic');
Mdl = TreeBagger(100, S', labels', 'oobpred', 'on', 'Method', 'classification');
% Mdl = fitcnb(S', labels);
% Mdl = fitctree(S', labels, 'PredictorNames', {'SL' 'SW' });


% validations
totAcc = 0.0;
count = 0;
fprintf('Starting validation\n');
for label = 0:9
	[acc, c, pred] = validate(Mdl, label, A, blockSize, lambda);
	totAcc = totAcc + acc;
	count = count + c;
	acc = acc * 100 / c;
	fprintf('Accuracy for class %d: %f\n', label, acc);
end

fprintf('Average accuracy: %f\n', 100*totAcc/count);

toc;