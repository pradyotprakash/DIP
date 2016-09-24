function [ V1, D1 ] = sortEigenVectors( V,D )
%UNTITLED Summary of this function goes here
EigValues = diag(D);
V1 = zeros(size(V,1),size(V,2));
[D1, index] = sort(EigValues);
for i = 1:size(V,2)
    V1(:,i) = V(:,index(i));
end

%   Detailed explanation goes here


end

