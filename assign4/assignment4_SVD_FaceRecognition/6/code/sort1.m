function [V1] = sort1(V, D)
	V1 = zeros(size(V));
	[D1, index] = sort(D, 'descend');
	for i = 1:size(V, 1)
		V1(i,1) = V(index(i),1);
	end
end