%% MyMainScript
tic;
%% Your code here
im_barbara = imread('../data/barbara.png');
out_barbara_LCS = myLinearContrastStretching(im_barbara); % Generates  global enhanced image after histogram equalization
save('barbara_LinearContrastStrectching.mat','out_barbara_LCS');
out_barbara_HE = myHE(im_barbara);
save('barbara_HE.mat','out_barbara_HE');
out_barbara_AHE_36 = myAHE(im_barbara, 36);
save('barbara_AHE_N_36.mat','out_barbara_AHE_36');
out_barbara_AHE_64 = myAHE(im_barbara, 64);
save('barbara_AHE_N_64.mat','out_barbara_AHE_64');
out_barbara_AHE_100 = myAHE(im_barbara, 100);
save('barbara_AHE_N_100.mat','out_barbara_AHE_100');
out_barbara_CLAHE_01 = myCLAHE(im_barbara, 36, 0.01);
save('barbara_CLAHE_N_36_E_01.mat','out_barbara_CLAHE_01');
out_barbara_CLAHE_005 = myCLAHE(im_barbara, 36, 0.005);
save('barbara_CLAHE_N_36_E_005.mat','out_barbara_CLAHE_005');

im_canyon = imread('../data/canyon.png');
im_canyon_r = im_canyon(:,:,1);
im_canyon_g = im_canyon(:,:,2);
im_canyon_b = im_canyon(:,:,3);
out_canyon_LCS = cat(3,myLinearContrastStretching(im_canyon_r),myLinearContrastStretching(im_canyon_g),myLinearContrastStretching(im_canyon_b)); % Generates  global enhanced image after histogram equalization
save('canyon_LinearContrastStrectching.mat','out_canyon_LCS');
out_canyon_HE = cat(3,myHE(im_canyon_r),myHE(im_canyon_g),myHE(im_canyon_b));
save('canyon_HE.mat','out_canyon_HE');
out_canyon_AHE_36 = cat(3,myAHE(im_canyon_r, 36),myAHE(im_canyon_g, 36),myAHE(im_canyon_b,  36));
save('canyon_AHE_N_36.mat','out_canyon_AHE_36');
out_canyon_AHE_64 = cat(3,myAHE(im_canyon_r, 64),myAHE(im_canyon_g, 64),myAHE(im_canyon_b,  64));
save('canyon_AHE_N_64.mat','out_canyon_AHE_64');
out_canyon_AHE_100 = cat(3,myAHE(im_canyon_r, 100),myAHE(im_canyon_g, 100),myAHE(im_canyon_b, 100));
save('canyon_AHE_N_100.mat','out_canyon_AHE_100');
out_canyon_CLAHE_01 = cat(3,myCLAHE(im_canyon_r, 36,0.01),myCLAHE(im_canyon_g, 36,0.01),myCLAHE(im_canyon_b,36,0.01));
save('canyon_CLAHE_N_36_E_01.mat','out_canyon_CLAHE_01');
out_canyon_CLAHE_005 = cat(3,myCLAHE(im_canyon_r, 36,0.005),myCLAHE(im_canyon_g, 36,0.005),myCLAHE(im_canyon_b,36,0.005));
save('canyon_CLAHE_N_36_E_005.mat','out_canyon_CLAHE_005');

im_TEM = imread('../data/TEM.png');
out_TEM_LCS = myLinearContrastStretching(im_TEM); % Generates  global enhanced image after histogram equalization
save('TEM_LinearContrastStrectching.mat','out_TEM_LCS');
out_TEM_HE = myHE(im_TEM);
save('TEM_HE.mat','out_TEM_HE');
out_TEM_AHE_36 = myAHE(im_TEM, 36);
save('TEM_AHE_N_36.mat','out_TEM_AHE_36');
out_TEM_AHE_64 = myAHE(im_TEM, 64);
save('TEM_AHE_N_64.mat','out_TEM_AHE_64');
out_TEM_AHE_100 = myAHE(im_TEM, 100);
save('TEM_AHE_N_100.mat','out_TEM_AHE_100');
out_TEM_CLAHE_01 = myCLAHE(im_TEM, 36, 0.01);
save('TEM_CLAHE_N_36_E_01.mat','out_TEM_CLAHE_01');
out_TEM_CLAHE_005 = myCLAHE(im_TEM, 36, 0.005);
save('TEM_CLAHE_N_36_E_005.mat','out_TEM_CLAHE_005');


toc;
