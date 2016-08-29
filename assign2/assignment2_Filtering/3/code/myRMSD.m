function [ RMSD ] = myRMSD( A, B )
RMSD = sum(sum((A-B).^2));
RMSD = sqrt(RMSD/(size(A-B,1)*size(A-B,2)));
end

