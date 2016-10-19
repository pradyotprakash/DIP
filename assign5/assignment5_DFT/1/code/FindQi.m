function [ TopQ, N ] = FindQi( im,P,a,b,N,L,K)
x1 = a-L;
if x1 <= 1
    x1 = 1;
end

x2 = a+L;
if x2 > size(im,1)
    x2 = size(im,1);
end

y1 = b-L;
if y1 <= 1
    y1 = 1;
end

y2 = b+L;
if y2 > size(im,2)
    y2 = size(im,2);
end

Q_Neighbourhood = im(x1:x2,y1:y2);
[sizeX, sizeY] = size(Q_Neighbourhood);

sizeQ_X = sizeX-2*N;
sizeQ_Y = sizeY-2*N;
Q = zeros((2*N+1)*(2*N+1),sizeQ_X*sizeQ_Y);
for i = 1:sizeQ_X
    for j = 1:sizeQ_Y
        im1Patch = Q_Neighbourhood(i:i+2*N,j:j+2*N);
        im1Patch_Col = im1Patch(:);
%         disp(strcat(int2str(i),int2str(j)));
        Q(:,(i-1)*sizeQ_X + j) = im1Patch_Col; 
    end
end
Q_P_Diff_2 = sum((Q - repmat(P,1,size(Q,2))).^2,1);
[E,index] = sort(Q_P_Diff_2,2);
% min(Q_P_Diff_2)
index = index(1:min(K,size(index,2)));
N = size(index,2);
TopQ = Q(:,index);
