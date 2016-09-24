tic;
N = 38; % Number of faces
N_training = 40; % Training Images per face
N_total = 60;

database_name = uigetdir();
listing = dir(database_name);
listing_image = dir(strcat(database_name,'/',listing(4).name));
n  = listing_image(4).name;
x = imread(strcat(database_name,'/',listing(4).name,'/',n));
d = prod(size(x)); % Dimension of one image

X = zeros(d,N*N_training);

disp('Collecting Training Data');
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
V_C = X*V; 

%Unit Normalise the eigenvectors
V_C = V_C ./ (repmat(sum(V_C.^2),d,1).^0.5);
X_eigenface = V_C'*X;


X_test = zeros(d,N*(N_total-N_training));
disp('Collectiong Test Images');
count = 0;
listing = dir(database_name);
for i=1:N
    listing_image = dir(strcat(database_name,'/',listing(i+2).name));
    for j=1:(N_total-N_training)
        n  = listing_image(j+2+N_training).name;
        x = imread(strcat(database_name,'/',listing(i+2).name,'/',n));
        X_test(:,(i-1)*(N_total-N_training) + j) = x(:);
        count = count + 1;
    end
    disp(strcat('Collected images from: ',int2str(i),' th Face'));
end

X_test = X_test - repmat(x_mean,1,size(X_test,2));
X_Projection = V_C'*X_test;


K = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
K_recognition_rate = zeros(1,size(K,2));
for a=1:size(K,2)
    k = K(a);
    disp(strcat('Started Testing for k = ',int2str(k)));

    % Pick the top k eigenvectors
    X_eigenface_k = X_eigenface((N*N_training)-k-2:(N*N_training)-3,:);
    X_Projection_k = X_Projection((N*N_training)-k-2:(N*N_training)-3,:);
        
    
    % Get eigenface of each image
    count = 0;
    for i=1:size(X_test,2)
        X_Diff = repmat(X_Projection_k(:,i),1,N*N_training) - X_eigenface_k;
        [Min,Min_Image_Index] =  min(sum(X_Diff.^2));
        
        if floor((i-1)/(N_total-N_training)) == floor((Min_Image_Index-1)/(N_training))
            count = count+1;
        end
        
    end
    K_recognition_rate(a) = double(count)*100/size(X_test,2);

end
figure(1);

plot(K,K_recognition_rate);
title('Recognition Rate for different k (in %)');
xlabel('k');
ylabel('Recognition Rate');

toc;