function [U, S, V] = mySVD(A)
	% UNTITLED2 Summary of this function goes here
	% Detailed explanation goes here

	[U, D1] = eig(A*A');
	[U, D1] = sortEigenVectors(U, D1);
	U = normc(U);

	[V, D2] = eig(A'*A);
	[V, D2] = sortEigenVectors(V, D2);
	V = normc(V);

	if size(D1, 1) < size(D2, 1)
		D = sqrt(max(0, D1));
	else
		D = sqrt(max(0, D2));
	end

	S = zeros(size(A));

	for i = 1:size(D, 1)
		S(i, i) = D(i, i);
	end

	T1 = A*V;
	T2 = U*S;

	for i = 1:size(T1, 2)
		if abs(T1(:, i) - T2(:, i)) > 1e-2
			V(:, i) = -V(:, i);
		end
	end
end