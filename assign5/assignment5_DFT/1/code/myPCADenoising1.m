function [im_Final] = myPCADenoising1(im1,Sigma)

[sizeX, sizeY] = size(im1);
N = 3;
vx = 1;
vy = 1;

sizeP_X = floor(((sizeX-1-2*N)/(vx))+1);
sizeP_Y = floor(((sizeY-1-2*N)/(vy))+1);
P = zeros((2*N+1)*(2*N+1),sizeP_X*sizeP_Y);

% Finding Patches for each pixel
disp('Forming Patch Vector P');
for i = 1:sizeP_X
    for j = 1:sizeP_Y
%         disp(strcat('Patch Dimensions',int2str((i-1)*vx+1),':',int2str((i-1)*vx+1+(2*N)),',',int2str((j-1)*vy+1),':',int2str((j-1)*vy+(2*N)+1)));
%         disp(strcat('P Dimension:',int2str((i-1)*sizeP_X + j)));
        im1Patch = im1((i-1)*vx+1:(i-1)*vx+(2*N)+1,(j-1)*vy+1:(j-1)*vy+(2*N)+1);
        im1Patch_Col = im1Patch(:);
        P(:,(i-1)*sizeP_X + j) = im1Patch_Col; 
    end
end

A= P*(P');
[V,D] = eig(A);
EigenCoeff_Patch = (P'*V);
AvgSquared_EigenCoeff = sum(EigenCoeff_Patch.^2,1)/(sizeP_X*sizeP_Y)-Sigma^2*ones(1,(2*N +1)^2);
for i = 1:(2*N +1)^2    
    if AvgSquared_EigenCoeff(1,i) < 0
        AvgSquared_EigenCoeff(1,i) = 0;
    end
end

EigenCoeff_Patch_Denoised = zeros(size(EigenCoeff_Patch));
for i = 1:size(EigenCoeff_Patch,1)
    for j = 1:size(EigenCoeff_Patch,2)
    EigenCoeff_Patch_Denoised(i,j) = EigenCoeff_Patch(i,j)/(1 + (Sigma^2)/(AvgSquared_EigenCoeff(1,j))); 
    end
end

P_Final = (EigenCoeff_Patch_Denoised*V')';

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
for i = 1:sizeX
    for j =1:sizeY
        if Pixel_Count(i,j) == 0
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