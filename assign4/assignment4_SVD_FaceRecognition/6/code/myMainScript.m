x1 = [-1;10;0.3];
x2 = [-0;12;-1.3];
x3 = [-0.1;-3;2.12];
x4 = [-0;2.33;-3.31];

X = [x1, x2, x3, x4];
W = [1,0,0;0,1,0;0,0,1];

C = X*X';
[V, ~] = eig(C);

k = 2;
approx_error1 = 0.0;
for i = 1:size(X, 2)
	ai = V'*X(:, i);
	bi = sort1(ai, abs(ai));
	for j = k+1:size(X,1)
		approx_error1 = approx_error1 + (bi(j, 1).^2);
	end
end

approx_error2 = 0.0;
for i = 1:size(X, 2)
	ai = W'*X(:, i);
	bi = sort1(ai, abs(ai));
	for j = k+1:size(X,1)
		approx_error2 = approx_error2 + (bi(j, 1).^2);
	end
end

fprintf('Error using V: %f; Error using W: %f\n', approx_error1, approx_error2);