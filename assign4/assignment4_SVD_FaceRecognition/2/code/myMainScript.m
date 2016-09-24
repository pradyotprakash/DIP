tic;
N = 38; % Number of faces
N_training = 40; % Training Images per face
% h = waitbar(0,'Collecting Training Data');

database_name = uigetdir();
listing = dir(database_name);
listing_image = dir(strcat(database_name,'/',listing(4).name));
n  = listing_image(4).name;
x = imread(strcat(database_name,'/',listing(4).name,'/',n));
[sizeX, sizeY] = size(x);
d = prod(size(x)); % Dimension of one image


X = zeros(d,N*N_training);
listing = dir(database_name);
count = 0;
for i=1:N
    listing_image = dir(strcat(database_name,'/',listing(i+2).name));
    for j=1:N_training
        n  = listing_image(j+2).name;
        x = imread(strcat(database_name,'/',listing(i+2).name,'/',n));
        X(:,(i-1)*N_training + j) = x(:);
        count = count + 1;
%         waitbar(double(count)/double(N*N_training),h);
    end
    disp(strcat('Collected images from: ',int2str(i),' th Face'));
end
% close(h);

% Mean Vector
x_mean = sum(X')'/d;

for i=1:N
    for j=1:N_training
        X(:,(i-1)*N_training + j) = X(:,(i-1)*N_training + j)-x_mean;
    end
end

L = X'*X;
disp('Finding eigenvectors of X''X');
[V, D] = eig(L);   

% Find the eigenvectors of C from V
disp('Find the eigenvectors of C from V');
V_C = X*V; 

%Unit Normalise the eigenvectors
disp('Unit Normalization');
V_C = V_C ./ (repmat(sum(V_C.^2),d,1).^0.5);
X_eigenface = V_C'*X;

X = X - repmat(x_mean,1,size(X,2));
X_Projection = V_C'*X;

K = [2, 10, 20, 50, 75, 100, 125, 150, 175];
K_recognition_rate = zeros(1,size(K,2));

i=3;
figure(1);
title('Eigenvalue approximation for Test Image (with increasing k'); 
for a=1:size(K,2)
    k =K(a);
%   Pick the top k eigenvectors' Components
    X_eigenface_k = X_eigenface((N*N_training)-k+1:(N*N_training),:);
    X_Projection_k = X_Projection((N*N_training)-k+1:(N*N_training),:);
    V_C_k = V_C(:,(N*N_training)-k+1:(N*N_training));
  
    X_image_k = X_Projection_k(:,i);
    X_image = V_C_k*X_image_k;
    X_image = X_image + x_mean;
    subplot(2,5,a);
    imshow(uint8(reshape(X_image,sizeX,sizeY)));
    
    
end
subplot(2,5,10);
imshow(uint8(reshape(X(:,i),sizeX,sizeY)));

figure(2);
for k=1:25
    subplot(5,5,k);
    imshow(uint8(reshape(X_Projection(N*N_training-k+1,i)*V_C(:,N*N_training-k+1)+x_mean,sizeX,sizeY)));
        
end
toc;