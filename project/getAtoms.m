function [A, X] = getAtoms(label, m, blockSize, lambda)
	fprintf('Collecting data for label: %d\n', label);

	X = prepareData(label, blockSize, 'train');

	d = size(X, 1);
	n = size(X, 2);

	sinit = abs(rand(m, n, 'single') + 1);
	ainit = normc(abs(rand(d, m, 'single') + 1));

	fprintf('Initialization done\n');
	fprintf('Starting convergence operations for label: %d\n', label);

	iter = 0;
	max_iter = 1000;
	thres = 1e-4;

	A = ainit;
	S = sinit;
	vals = [];

	mu = 1e-3;

	clear sinit ainit;

	repeat = 0;
	val = funcval(X, A, S, lambda);
	while iter < max_iter
		if repeat == 0
			vallast = val;
		end

		A_new = A - mu * (A * S - X) * S';
		A_new = normc(max(0, A_new));

		S_new = S .* (A_new' * X) ./ ((A_new' * A_new * S) + lambda);
		val = funcval(X, A_new, S_new, lambda);

		if abs((val - vallast)/vallast) < thres
			break;
		end
		
		if val > vallast
			mu = mu * 0.5;
			repeat = 1;
			continue;
		else
			mu = mu * 1.1;
			repeat = 0;
			iter = iter + 1;
		end

		A = A_new;
		S = S_new;
		vals = [vals, val];

		fprintf('iter: %d, val: %d\n', iter, val);
	end

	fprintf('Convergence complete\n');

	clear vals S A_new S_new;

end