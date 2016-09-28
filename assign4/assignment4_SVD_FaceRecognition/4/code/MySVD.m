function [U, S, V] = mySVD(A)
	% UNTITLED2 Summary of this function goes here
	% Detailed explanation goes here
	[U, D1] = eig(A*A');
	[V, D2] = eig(A'*A);
	if size(D1, 1) < size(D2, 1)
		D = sqrt(max(0, D1));
	else
		D = sqrt(max(0, D2));
	end

	S = zeros(size(A));

	for i = 1:size(D, 1)
		S(i, i) = D(i, i);
	end
end