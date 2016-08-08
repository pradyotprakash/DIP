%% MyMainScript
tic;
%% Your code here
im_barbara = imread('../data/beach.png');
out_barbara = myHE(im_barbara); % Generates  global enhanced image after histogram equalization
% out_barbara_AHE = myAHE(im_barbara, 64); % Generates  global enhanced image after histogram equalization
% out_barbara_contractstretching = myLinearContrastStretching(im_barbara);
out_barbara_CLAHE = myCLAHE(im_barbara, 32, 0.5); % Generates  global enhanced image after histogram equalization
myShowImage(im_barbara);
% myShowImage(out_barbara);
% myShowImage(out_barbara_AHE);
% myShowImage(out_barbara_contractstretching);
myShowImage(out_barbara_CLAHE);

% im_canyon = imread('../data/canyon.png');
% im_canyon_r = im_canyon(:,:,1);
% im_canyon_g = im_canyon(:,:,2);
% im_canyon_b = im_canyon(:,:,3);
% out_canyon = cat(3,myHE(im_canyon_r),myHE(im_canyon_g),myHE(im_canyon_b)); % Generates global enhanced image after histogram equalization
% out_canyon_AHE = cat(3,myAHE(im_canyon_r,36),myAHE(im_canyon_g,36),myAHE(im_canyon_b,36));
% myShowImage(im_canyon);
% myShowImage(out_canyon);
% myShowImage(out_canyon_AHE);

% im_TEM = imread('../data/TEM.png');
% out_TEM = myHE(im_TEM); % Generates enhanced image after global histogram equalization
% myShowImage(im_TEM);
% myShowImage(out_TEM);
toc;
