function [ outputValue ] = myAHEBlock( inputBlock)
% Calculates the pixel value for the center of the block
[sizeX,sizeY] =  size(inputBlock);

outputBlock = myHE(inputBlock);
outputValue = outputBlock(int32(sizeX/2),int32(sizeY/2));

end

