function [im_Final] = myPCADenoising2(im1,Sigma)
digits(20);
[sizeX, sizeY] = size(im1);
N = 3;
L = 15;
K =  200;
vx = 1;
vy = 1;

sizeP_X = floor(((sizeX-1-2*N)/(vx))+1);
sizeP_Y = floor(((sizeY-1-2*N)/(vy))+1);
P = zeros((2*N+1)*(2*N+1),sizeP_X*sizeP_Y);
Q_n = zeros(1,sizeP_X*sizeP_Y);


EigenCoeff_Patch = double(zeros((2*N+1)^2,sizeP_X*sizeP_Y));
EigenCoeff_Patch_Denoised = (double(zeros(size(EigenCoeff_Patch))));
P_Final = zeros(size(P));
% Finding Patches for each pixel
disp('Forming Patch Vector P and Corresponding Similar Patch Vector Q');
for i = 1:sizeP_X
    for j = 1:sizeP_Y
%         disp(strcat('Patch Dimensions',int2str((i-1)*vx+1),':',int2str((i-1)*vx+1+(2*N)),',',int2str((j-1)*vy+1),':',int2str((j-1)*vy+(2*N)+1)));
%         disp(strcat('P Dimension:',int2str((i-1)*sizeP_X + j)));
        im1Patch = im1((i-1)*vx+1:(i-1)*vx+(2*N)+1,(j-1)*vy+1:(j-1)*vy+(2*N)+1);
        im1Patch_Col = im1Patch(:);
        [Q_i,n1] = FindQi(im1,im1Patch_Col,(i-1)*vx+1,(j-1)*vy+1,N,L,K);
        Q_n(:,(i-1)*sizeP_X+j,1:size(Q_i,2)) = n1;
  
        [V,D] = eig(Q_i*Q_i');
        V = normc(V);
  
        EigenCoeff_Patch(:,i) = conj(V)'*(im1Patch_Col);
        AvgSquared_EigenCoeff = (sum((conj(V)'*Q_i).^2,2)/Q_n(1,i))- double(Sigma^2*ones((2*N+1)^2,1));
        for k =1:(2*N+1)^2
            AvgSquared_EigenCoeff(k,1) = max(0,AvgSquared_EigenCoeff(k,1));
        end
        
        EigenCoeff_Patch_Denoised(:,i) = EigenCoeff_Patch(:,i)./(ones((2*N+1)^2,1)+((Sigma^2)*(AvgSquared_EigenCoeff).^-1))  ;
        P_Final(:,(i-1)*sizeP_X + j) = (V*EigenCoeff_Patch_Denoised(:,i));
    end
end
% 
im_Final = zeros(size(im1));
Pixel_Count = zeros(size(im1));
disp('Reassembling Patch Vector to form Final Image');
% Reassembling Patch Code
for i = 1:sizeP_X
    for j = 1:sizeP_Y
        Im_Patch_Col = P_Final(:,(i-1)*sizeP_X + j);
        Im_Patch = reshape(Im_Patch_Col,(2*N) +1, (2*N) +1);
        im_Final((i-1)*vx+1:(i-1)*vx+(2*N)+1,(j-1)*vy+1:(j-1)*vy+(2*N)+1) = im_Final((i-1)*vx+1:(i-1)*vx+(2*N)+1,(j-1)*vy+1:(j-1)*vy+(2*N)+1)+ Im_Patch;
        Pixel_Count((i-1)*vx+1:(i-1)*vx+(2*N)+1,(j-1)*vy+1:(j-1)*vy+(2*N)+1) = Pixel_Count((i-1)*vx+1:(i-1)*vx+(2*N)+1,(j-1)*vy+1:(j-1)*vy+(2*N)+1) + 1; 
    end
end

Pixel_Count1 = Pixel_Count;
count = 0;
for i = 1:sizeX
    for j =1:sizeY
        if Pixel_Count(i,j) == 0
            count = count + 1;
            for a = -4:4
                for b = -4:4
                    if (a+i<=sizeX) & (b+j<=sizeY) & (a+i>0) & (b+j>0)
                        if (Pixel_Count(a+i,b+j)~=0)    
                            Pixel_Count1(i,j) = Pixel_Count1(i,j) + Pixel_Count1(a+i,b+j);
                            im_Final(i,j) = im_Final(i,j) + im_Final(a+i,b+j);
                        end    
                    end
                end
            end
        end
    end
end
im_Final = im_Final./Pixel_Count1;
end