function [ outputImage ] = myMeanShiftSegmentation( inputImage, hs, hr, Iterations)

[sizeX, sizeY] = size(inputImage(:,:,1));
inputImage1 = double(inputImage);
outputImage = double(inputImage);
h = waitbar(0, 'Mean Shift Segmentation in Progress...');
count = 0;
In_R = inputImage1(:,:,1);
In_G = inputImage1(:,:,2);
In_B = inputImage1(:,:,3);
In_X = double(zeros(sizeX,sizeY));
In_Y = double(zeros(sizeX,sizeY));



for i=1:sizeX
    for j=1:sizeY
        In_X(i,j)=i;
        In_Y(i,j)=j;
    end
end


MR = double(ones(sizeX,sizeY));
MG = double(ones(sizeX,sizeY));
MB = double(ones(sizeX,sizeY));
MS_X = double(ones(sizeX,sizeY));
MS_Y = double(ones(sizeX,sizeY));
            


for N = 1:Iterations
    tic;
    for i=1:sizeX
        for j=1:sizeY
            MR = MR*inputImage1(i,j,1)/max(max(MR));
            MG = MG*inputImage1(i,j,2)/max(max(MG));
            MB = MB*inputImage1(i,j,3)/max(max(MB));
            MS_X = MS_X*i/max(max(MS_X));
            MS_Y = MS_Y*j/max(max(MS_Y));
            WeightRGB_M = exp((-(In_R-MR).^2 - (In_G-MG).^2 - (In_B-MB).^2) /(2*(hr^2)) - ( (MS_X-In_X).^2 + (MS_Y-In_Y).^2 )/2*(hs^2)); 
            Func = sum(sum(WeightRGB_M));
            MeanShift_R = (sum(sum(WeightRGB_M.*In_R)))/Func - inputImage1(i,j,1);
            MeanShift_G = (sum(sum(WeightRGB_M.*In_G)))/Func - inputImage1(i,j,2);
            MeanShift_B = (sum(sum(WeightRGB_M.*In_B)))/Func - inputImage1(i,j,3);
   
            count = count + 1;
            outputImage(i,j,1) = double(outputImage(i,j,1)) + (MeanShift_R);
            outputImage(i,j,2) = double(outputImage(i,j,2)) + (MeanShift_G);
            outputImage(i,j,3) = double(outputImage(i,j,3)) + (MeanShift_B);
            waitbar(count/double(sizeX*sizeY*Iterations));
        end
    end
    toc;
    'No of Iterations completed: ', N
    inputImage1 = outputImage;
end

end

