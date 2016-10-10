function y = funcval(X, A, S, lambda)
	y = 0.5 .* sum(sum(((X - (A*S)).^2))) + lambda .* sum(sum(S));
end