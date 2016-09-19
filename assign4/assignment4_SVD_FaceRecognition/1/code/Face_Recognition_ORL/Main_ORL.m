tic;
N = 32; % Number of faces
N_training = 6; % Training Images per face

x = imread('database/s1/1.pgm');
d = prod(size(x)); % Dimension of one image

X = zeros(d,N*N_training);

disp('Collecting Training Data');
for i=1:N
    for j=1:N_training
        x = imread(strcat('database/s',int2str(i),'/',int2str(j),'.pgm'));
        %y = myLinearContrastStretching(x);
        X(:,(i-1)*N_training + j) = x(:);
    end
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


disp('Collecting Test data');
    X_test = zeros(d,N*(10-N_training));
    for i=1:N
        for j=1:10-N_training
            x = imread(strcat('database/s',int2str(i),'/',int2str(j+N_training),'.pgm'));
            %y = myLinearContrastStretching(x);
            X_test(:,(i-1)*(10-N_training) + j) = x(:);
        end
    end

X_test = X_test - repmat(x_mean,1,size(X_test,2));
X_Projection = V_C'*X_test;


K = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
K_recognition_rate = zeros(1,size(K,2));

for a=1:size(K,2)
    k = K(a);
    % Pick the top k eigenvectors
    X_eigenface_k = X_eigenface((N*N_training)-k+1:(N*N_training),:);
    X_Projection_k = X_Projection((N*N_training)-k+1:(N*N_training),:);
        
    
    % Get eigenface of each image
    count = 0;
    for i=1:size(X_test,2)
        X_Diff = repmat(X_Projection_k(:,i),1,N*N_training) - X_eigenface_k;
        [Min,Min_Image_Index] =  min(sum(X_Diff.^2));
        
        if floor((i-1)/(10-N_training)) == floor((Min_Image_Index-1)/(N_training))
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