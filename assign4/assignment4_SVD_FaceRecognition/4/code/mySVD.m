function [ U, S, V  ] = mySVD( A )
%UNTITLED2 Summary of this function goes here
[sizeR, sizeC] = size(A);
%   Detailed explanation goes here
[U, D1] = eig(A*A');
[V, D2] = eig(A'*A);
U = fliplr(U);
V = fliplr(V);
S = U'*A*V;

end

