a = 1.1; b = 44; % Initial Parameters
A = myBilateralFiltering(im1,5,a,b);
Prev_Cost = RMSD(im,A);
disp('Looking for optimal parameters for Bilateral Filtering');
Continue_Iter = 1;
while Continue_Iter == 1
    A1 = myBilateralFiltering(im1,5,0.9*a,0.9*b);
    C1 = RMSD(im,A1);
    
    A2 = myBilateralFiltering(im1,5,1.1*a,0.9*b);
    C2 = RMSD(im,A2);
    
    A3 = myBilateralFiltering(im1,5,0.9*a,1.1*b);
    C3 = RMSD(im,A3);
    
    A4 = myBilateralFiltering(im1,5,1.1*a,1.1*b);
    C4 = RMSD(im,A1);
    
    MinCost = min([C1,C2,C3,C4]);
    if MinCost < Prev_Cost
        Prev_Cost = MinCost;
        if MinCost == C1
            a = 0.9*a; b = 0.9*b;
        end
        
        if MinCost == C2
            a = 1.1*a; b = 0.9*b;
        end
        
        if MinCost == C3
            a = 0.9*a; b = 1.1*b;
        end
        
        if MinCost == C4
            a = 1.1*a; b = 1.1*b;
        end
        disp(strcat('Minimum Cost: ',num2str(MinCost),',  (a,b) = (',num2str(a),', ',num2str(b),')'));
    if MinCost >= Prev_Cost
        Continue_Iter = 0;
    end
        
    end
    
end

disp(strcat('Optimal Parameters obtained are: ',num2str(a),num2str(b)));