%% MyMainScript
tic;
%% Your code here
im_barbara = imread('../data/barbara.png');
%out_barbara = myHE(im_barbara); % Generates  global enhanced image after histogram equalization
out_barbara_CLAHE = myCLAHE(im_barbara, 64,0.005); % Generates  global enhanced image after histogram equalization
%out_barbara_contractstretching = myLinearContrastStretching(im_barbara);
%out_barbara_CLAHE = myCLAHE(im_barbara, 64, 0.5); % Generates  global enhanced image after histogram equalization
%myShowImage(im_barbara);
% myShowImage(out_barbara);
% myShowImage(out_barbara_AHE);
%myShowImage(out_barbara_contractstretching);
%myShowImage(out_barbara_CLAHE);

 %im_canyon = imread('../data/canyon.png');
%im_canyon_r = im_canyon(:,:,1);
% im_canyon_g = im_canyon(:,:,2);
% im_canyon_b = im_canyon(:,:,3);
% out_canyon = cat(3,myLinearContrastStretching(im_canyon_r),myLinearContrastStretching(im_canyon_g),myLinearContrastStretching(im_canyon_b)); % Generates global enhanced image after histogram equalization
% out_canyon_AHE = cat(3,myAHE(im_canyon_r,36),myAHE(im_canyon_g,36),myAHE(im_canyon_b,36));
% myShowImage(im_canyon);
% myShowImage(out_canyon);
% myShowImage(out_canyon_AHE);

 im_TEM = imread('../data/TEM.png');
 %out_TEM_36 = myAHE(im_TEM,36); % Generates enhanced image after global histogram equalization
 %out_TEM_64 = myAHE(im_TEM,64); % Generates enhanced image after global histogram equalization
 %out_TEM_100 = myAHE(im_TEM,100); % Generates enhanced image after global histogram equalization

 myShowImage(im_barbara);
 myShowImage(out_barbara_CLAHE);
% myShowImage(out_TEM_64);
% myShowImage(out_TEM_100);
toc;
