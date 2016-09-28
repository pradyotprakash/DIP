function [V1, D1] = sortEigenVectors(V, D)
	%UNTITLED Summary of this function goes here
	eigValues = diag(D);
	V1 = zeros(size(V));
	[D1, index] = sort(eigValues, 'descend');
	for i = 1:size(V, 2)
		V1(:, i) = V(:, index(i));
	end
	% Detailed explanation goes here
end