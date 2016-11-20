tic;
fileID = fopen('exp.txt','a');

rng(0);

fprintf(fileID, 'Lambda vs accuracies\n====================\n');
lambda = 0;
for lambda = 0:0.1:1
	fprintf(fileID, 'Lambda: %d\n--------\n', lambda);
	blockSize = 14;

	numAtoms = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10];
	c = 0;
	A = zeros(blockSize^2, sum(numAtoms));
	X = [];
	labels = [];

	% fprintf('Starting computing atoms\n');

	for label = 0:9
		m = numAtoms(1, label + 1);
		[Ai, Xi] = getAtoms(label, m, blockSize, lambda);
		A(:, c + 1:c + m) = Ai;
		c = c + m;
		X = [X, Xi];
		labels = [labels, ones(1, size(Xi, 2)) * label];
		clear Ai Xi;
	end

	% fprintf('All atoms computed\n');
	% fprintf('Sparse coding the data\n');

	S = learnCodes(X, A, lambda);
	clear X;
	% fprintf('Convergence for S complete\n');

	% fprintf('Fitting random forest classifier\n');

	Mdl = TreeBagger(100, S', labels', 'oobpred', 'on', 'Method', 'classification');

	% validations
	totAcc = 0.0;
	count = 0;
	accuracies = [];
	% fprintf('Starting validation\n');
	for label = 0:9
		[acc, c, pred] = validate(Mdl, label, A, blockSize, lambda);
		totAcc = totAcc + acc;
		count = count + c;
		acc = acc * 100 / c;
		accuracies = [accuracies, acc];
		fprintf(fileID, 'Accuracy for class %d: %f\n', label, acc);
	end

	fprintf(fileID, 'Average accuracy: %f\n', 100*totAcc/count);
	% accuracies;
end


% fprintf(fileID, '\n\nAtoms vs accuracies\n====================\n');
% lambda = 0;
% for k = 10:10%[1, 2, 5, 8, 10, 12, 15, 20]
% 	fprintf(fileID, 'k: %d\n--------\n', k);
% 	blockSize = 14;
	
% 	numAtoms = k * [1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
% 	c = 0;
% 	A = zeros(blockSize^2, sum(numAtoms));
% 	X = [];
% 	labels = [];

% 	for label = 0:9
% 		m = numAtoms(1, label + 1);
% 		[Ai, Xi] = getAtoms(label, m, blockSize, lambda);
% 		A(:, c + 1:c + m) = Ai;
% 		c = c + m;
% 		X = [X, Xi];
% 		labels = [labels, ones(1, size(Xi, 2)) * label];
% 		clear Ai Xi;
% 	end

% 	S = learnCodes(X, A, lambda);
% 	clear X;
	
% 	Mdl = TreeBagger(100, S', labels', 'oobpred', 'on', 'Method', 'classification');

% 	totAcc = 0.0;
% 	count = 0;
% 	accuracies = [];

% 	for label = 0:9
% 		[acc, c, pred] = validate(Mdl, label, A, blockSize, lambda);
% 		totAcc = totAcc + acc;
% 		count = count + c;
% 		acc = acc * 100 / c;
% 		accuracies = [accuracies, acc];
% 		fprintf(fileID, 'Accuracy for class %d: %f\n', label, acc);
% 	end

% 	fprintf(fileID, 'Average accuracy: %f\n', 100*totAcc/count);
% end
fclose(fileID);
toc;