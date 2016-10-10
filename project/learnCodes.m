function [S] = learnCodes(X, A, lambda)

	d = size(X, 1);
	n = size(X, 2);
	m = size(A, 2);

	sinit = abs(rand(m, n) + 1);
	iter = 0;
	max_iter = 1000;
	thres = 1e-4;

	S = sinit;
	vals = [];

	mu = 1e-3;

	clear sinit;

	repeat = 0;
	val = funcval(X, A, S, lambda);
	while iter < max_iter
		if repeat == 0
			vallast = val;
		end

		S_new = S .* (A' * X) ./ ((A' * A * S) + lambda);
		val = funcval(X, A, S_new, lambda);

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

		S = S_new;
		vals = [vals, val];

		fprintf('iter: %d, val: %d\n', iter, val);
	end

	clear S_new vals;

end