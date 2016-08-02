%% MyMainScript
tic;
%% Your code here
im_barbara = imread('../data/barbara.png');
out_barbara = myAHE(im_barbara); % Generates enhanced image after histogram equalization
myShowImage(im_barbara);
myShowImage(out_barbara);

im_canyon = imread('../data/canyon.png');
im_canyon_r = im_canyon(:,:,1);
im_canyon_g = im_canyon(:,:,2);
im_canyon_b = im_canyon(:,:,3);
out_canyon = cat(3,myAHE(im_canyon_r),myAHE(im_canyon_g),myAHE(im_canyon_b)); % Generates enhanced image after histogram equalization
myShowImage(im_canyon);
myShowImage(out_canyon);

im_TEM = imread('../data/TEM.png');
out_TEM = myAHE(im_TEM); % Generates enhanced image after histogram equalization
myShowImage(im_TEM);
myShowImage(out_TEM);
toc;
