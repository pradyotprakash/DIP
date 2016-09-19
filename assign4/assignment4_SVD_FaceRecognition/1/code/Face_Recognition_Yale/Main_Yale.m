tic;
N = 38; % Number of faces
N_training = 40; % Training Images per face
% h = waitbar(0,'Collecting Training Data');

x = imread('database/YaleB01/yaleB01_P00A+000E+00.pgm');
d = prod(size(x(:)));

X = zeros(d,N*N_training);
listing = dir('database');
count = 0;
for i=1:N
    listing_image = dir(strcat('database/',listing(i+2).name));
    for j=1:N_training
        n  = listing_image(j+2).name;
        x = imread(strcat('database/',listing(i+2).name,'/',n));
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
[V, D] = sortEigenVectors(V,D);   

% Find the eigenvectors of C from V
disp('Find the eigenvectors of C from V');
V_C = X*V; 

%Unit Normalise the eigenvectors
disp('Unit Normalization');
V_C = V_C ./ (repmat(sum(V_C.^2),d,1).^0.5);
X_eigenface = V_C'*X;

 
X_test = zeros(d,N*(60-N_training));

% h = waitbar(0,'Collecting Test data');
disp('Collectiong Test Images');
count = 0;
listing = dir('database');
for i=1:N
    listing_image = dir(strcat('database/',listing(i+2).name));
    for j=1:(60-N_training)
        n  = listing_image(j+2+N_training).name;
        x = imread(strcat('database/',listing(i+2).name,'/',n));
        X_test(:,(i-1)*(60-N_training) + j) = x(:);
        count = count + 1;
    end
    disp(strcat('Collected images from: ',int2str(i),' th Face'));
end
X_test = X_test - repmat(x_mean,1,size(X_test,2));
X_Projection = V_C'*X_test;

K = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
K_recognition_rate = zeros(1,size(K,2));

for a=1:size(K,2)
    k =K(a);
%   Pick the top k eigenvectors' Components
    X_eigenface_k = X_eigenface((N*N_training)-k-2:(N*N_training)-3,:);
    X_Projection_k = X_Projection((N*N_training)-k-2:(N*N_training)-3,:);

    count = 0;
    for i=1:size(X_test,2)
        X_Diff = repmat(X_Projection_k(:,i),1,N*N_training) - X_eigenface_k;
        [Min,Min_Image_Index] =  min(sum(X_Diff.^2));
        if floor((i-1)/20) == floor((Min_Image_Index-1)/40)
            count = count+1;
        end
    end
    count,k
    K_recognition_rate(a) = double(count)*100/size(X_test,2);
end
figure(1);

plot(K,K_recognition_rate);
title('Recognition Rate for different k (in %)');
xlabel('k');
ylabel('Recognition Rate');

toc;