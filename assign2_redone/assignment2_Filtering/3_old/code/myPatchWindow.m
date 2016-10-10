function [ Weight_Window, Window] = myPatchWindow( inputImage, W, P,i,j,Sigma_I)
%UNTITLED3 Summary of this function goes here
[SizeX, SizeY] = size(inputImage);

        WindowX_L = max(1,i-W);
        WindowX_U = min(SizeX,i+W);
        WindowY_L = max(1,j-W);
        WindowY_U = min(SizeY,j+W);
        
        Window = inputImage(WindowX_L:WindowX_U,WindowY_L:WindowY_U);
        [WinSizeX, WinSizeY] = size(Window);
        Weight_Window = ones(WinSizeX,WinSizeY);
        
        SelfPatchX_L = max(1,i-P);
        SelfPatchX_U = min(SizeX,i+P);
        SelfPatchY_L = max(1,j-P);
        SelfPatchY_U = min(SizeY,j+P);
                
        SelfPatch = inputImage(SelfPatchX_L:SelfPatchX_U,SelfPatchY_L:SelfPatchY_U); 
        [SelfPatchX, SelfPatchY] = size(SelfPatch);
        for k = 1:WinSizeX
            for l = 1:WinSizeY
                PatchX_L = max(1,k-P);
                PatchX_U = min(WinSizeX,k+P);
                PatchY_L = max(1,l-P);
                PatchY_U = min(WinSizeY,l+P);
                Patch = Window(PatchX_L:PatchX_U,PatchY_L:PatchY_U);
                [PatchSizeX, PatchSizeY] = size(Patch);
                CroppedPatch = Patch(1:min(PatchSizeX,SelfPatchX),1:min(PatchSizeY,SelfPatchY));
                SelfCroppedPatch = SelfPatch(1:min(PatchSizeX,SelfPatchX),1:min(PatchSizeY,SelfPatchY));
                Diff = (SelfCroppedPatch-CroppedPatch);%.*(myGenerateGaussian(min(PatchSizeX,SelfPatchX),min(PatchSizeY,SelfPatchY),Sigma_X));
                Weight_Window(k,l) = sum(sum(Diff.^2))/(min(PatchSizeX,SelfPatchX)*min(PatchSizeY,SelfPatchY));
                
            end
            
        end
      Weight_Window = exp(-(Weight_Window)/(2*(Sigma_I^2)));%.*(myGenerateGaussian(WinSizeX,WinSizeY,Sigma_I));
%     Weight_Window = myGenerateGaussian(WinSizeX,WinSizeY,Sigma_X);
      Weight_Window = Weight_Window/sum(sum(Weight_Window));
              
end

