function [ eig1, eig2 ] = myFindEigenValue( A, B, C )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[sizeX, sizeY] = size(A);
eig1 = zeros(sizeX,sizeY);
eig2 = zeros(sizeX,sizeY);
for i = 1:sizeX
    for j = 1:sizeY
        E = eig([A(i,j) B(i,j); B(i,j) C(i,j)]);
        eig1(i,j)=E(1);
        eig2(i,j)=E(2);
    end
end


end

