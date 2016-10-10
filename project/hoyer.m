tic;

% prepareData;

d = size(X, 1);
m = 50;
n = size(X, 2);

rng(23);
sinit = abs(rand(m, n) + 1);
ainit = normc(abs(rand(d, m) + 1));

fprintf('Initialization done\nStarting convergence operations\n');

iter = 0;
max_iter = 1000;
thres = 1e-4;

A = ainit;
S = sinit;
vals = [];

lambda = 10;
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

toc;