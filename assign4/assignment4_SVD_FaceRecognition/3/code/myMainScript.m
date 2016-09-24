tic;
N = 32; % Number of faces
N_training = 6; % Training Images per face
N_total = 10;
database_name = uigetdir();
listing = dir(database_name);
listing_image = dir(strcat(database_name,'/',listing(4).name));
n  = listing_image(4).name;
x = imread(strcat(database_name,'/',listing(4).name,'/',n));
d = prod(size(x)); % Dimension of one image
Threshold = 0.66;


disp('Collecting Training Data');
X = zeros(d,N*N_training);
count = 0;
for i=1:N
    listing_image = dir(strcat(database_name,'/',listing(i+3).name));
    for j=1:N_training
        n  = listing_image(j+2).name;
        x = imread(strcat(database_name,'/',listing(i+3).name,'/',n));
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

% Find the eigenvectors of C from V
V_C = X*V; 

%Unit Normalise the eigenvectors
V_C = V_C ./ (repmat(sum(V_C.^2),d,1).^0.5);
X_eigenface = V_C'*X;
Face_Mean = zeros(d,N);
Face_Radius = zeros(1,N);

for i=1:N
    X_Mean = sum(X_eigenface(:,(i-1)*N_training+1:i*N_training))/N_training;
end


disp('Collectiong Test Images');
count = 0;
listing = dir(database_name);
for i=1:N
    listing_image = dir(strcat(database_name,'/',listing(i+3).name));
    for j=1:(N_total-N_training)
        n  = listing_image(j+2+N_training).name;
        x = imread(strcat(database_name,'/',listing(i+3).name,'/',n));
        X_test(:,(i-1)*(N_total-N_training) + j) = x(:);
        count = count + 1;
    end
    disp(strcat('Collected images from: ',int2str(i),' th Face'));
end

X_test = X_test - repmat(x_mean,1,size(X_test,2));
X_Projection = V_C'*X_test;


K = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
K_recognition_rate = zeros(1,size(K,2));
K_false_negative = zeros(1,size(K,2));
K_true_negative = zeros(1,size(K,2));

for a=1:size(K,2)
    k = K(a);
    % Pick the top k eigenvectors
    X_eigenface_k = X_eigenface((N*N_training)-k+1:(N*N_training),:);
    X_Projection_k = X_Projection((N*N_training)-k+1:(N*N_training),:);
    
    % Calculate Radius
    Face_Mean_k = Face_Mean(N*N_training-k+1:N*N_training,:);
    for b = 1:N
        RadiusMax = 0;
        for c=1:N_training
            T = sqrt(sum((X_eigenface_k(:,(b-1)*N_training+c)-Face_Mean_k(:,b)).^2));
            if T>RadiusMax
                RadiusMax = T;
            end
        end
        Face_Radius(1,b)=RadiusMax;
    end
    
%     V_C_k = V_C(:,(N*N_training)-k+1:(N*N_training));
    
    % Get eigenface of each image
    count = 0;
    false_neg = 0;
    for i=1:size(X_test,2)
        X_Diff = repmat(X_Projection_k(:,i),1,N*N_training) - X_eigenface_k;
        [Min,Min_Image_Index] =  min(sum(X_Diff.^2));
        Radius = sum((X_Projection_k(:,i)- Face_Mean(1,floor((Min_Image_Index-1)/N_training)+1)).^2);
        Radius = sqrt(Radius);
        
        if sqrt(Radius) <= Threshold*Face_Radius(1,floor((Min_Image_Index-1)/N_training)+1)
            if floor((i-1)/(10-N_training)) == floor((Min_Image_Index-1)/(N_training))
                count = count+1;
            end
        else
            false_neg = false_neg + 1;
        end
    end
    K_recognition_rate(a) = double(count)*100/size(X_test,2);
    K_false_negative(a) = double(false_neg)*100/size(X_test,2);
end



disp('Collecting False Test data');
listing = dir(database_name);
N1 = 8;
N1_training = 10;
X_test_false = zeros(d,N1*N1_training);
    for i=N+1:N+N1
        listing_image = dir(strcat(database_name,'/',listing(i+2).name));
        for j=1:N1_training
            n  = listing_image(j+2).name;
            x = imread(strcat(database_name,'/',listing(i+2).name,'/',n));
            X_test_false(:,(i-N-1)*(N1_training) + j) = x(:);
        end
    end
X_test_false = X_test_false - repmat(x_mean,1,size(X_test_false,2));
X_Projection_false = V_C'*X_test_false;


for a=1:size(K,2)
    k = K(a);
    % Pick the top k eigenvectors
    X_eigenface_k = X_eigenface((N*N_training)-k+1:(N*N_training),:);
    X_Projection_false_k = X_Projection_false((N*N_training)-k+1:(N*N_training),:);
    
    % Calculate Radius
    Face_Mean_k = double(Face_Mean(N*N_training-k+1:N*N_training,:));
    for b = 1:N
        RadiusMax = 0;
        for c=1:N_training
            T = sqrt(sum((X_eigenface_k(:,(b-1)*N_training+c)-Face_Mean_k(:,b)).^2));
            if T>RadiusMax
                RadiusMax = T;
            end
        end
        Face_Radius(1,b)=RadiusMax;
    end
    
%     V_C_k = V_C(:,(N*N_training)-k+1:(N*N_training));
    
    % Get eigenface of each image
    count = 0;
    true_neg = 0;
    for i=1:size(X_Projection_false_k,2)
        X_Diff = repmat(X_Projection_false_k(:,i),1,N*N_training) - X_eigenface_k;
        [Min,Min_Image_Index] =  min(sum(X_Diff.^2));
        Radius = sum((X_Projection_false_k(:,i)- Face_Mean(1,floor((Min_Image_Index-1)/N_training)+1)).^2);
        Radius = sqrt(Radius);
        if Radius > Threshold*double(Face_Radius(1,floor((Min_Image_Index-1)/N_training)+1))
            true_neg = true_neg + 1;
        end
    end
    K_true_negative(a) = double(true_neg)*100/size(X_test_false,2);

end

figure(1);

plot(K,K_recognition_rate);
title('Recognition Rate for different k (in %)');
xlabel('k');
ylabel('Recognition Rate');

figure(2);
plot(K,K_false_negative);
title('False Negatives for different k (in %)');
xlabel('k');


figure(3);
plot(K,K_true_negative);
title('True Negatives for different k (in %)');
xlabel('k');
ylabel('Recognition Rate');


toc;