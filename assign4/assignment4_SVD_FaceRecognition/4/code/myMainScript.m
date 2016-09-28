%% MyMainScript

tic;
%% Your code here
A = dlmread('matA.txt');
[U, S, V] = MySVD(A);
fprintf('RMS error: %f\n', sum(sum((A - U*S*V') .^ 2)));
toc;