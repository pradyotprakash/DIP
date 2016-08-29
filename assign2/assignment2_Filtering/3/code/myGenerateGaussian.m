function [ GaussianWindow ] = myGenerateGaussian( x, y, Sigma )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
GaussianWindow = zeros(x,y);
c = [(x+1)/2, (y+1)/2];
for i = 1:x
    for j = 1:y
        dist = (i-c(1))^2 + (j-c(2))^2;
        GaussianWindow(i,j) = exp(-(dist)/(2*(Sigma^2)));
    end
end     

end

