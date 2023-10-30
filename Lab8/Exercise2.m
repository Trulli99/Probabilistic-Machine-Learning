%% LAB 8 - Exercise 2
clc; clear; %close all;
data = dir(['./fr*set']);
k=1;

[X_train1,X_test1] = F_dataset_multiclass(data(k));
fprintf('\n Dataset: %s \n',data(k).name);
labels = unique(X_train1(:,end))';
nr_class = length(labels);
fprintf("Number of classes: %d\n",nr_class)
L_tr = false( nr_class, size(X_train1,1) );
L_te = false( nr_class, size(X_test1,1) );
for c=1:nr_class
    ix = X_train1(:,end) == labels(c);
    L_tr(c,ix) = true;
    ix = X_test1(:,end) == labels(c);
    L_te(c,ix) = true;
end

ifea = [3:5,8:9,129:131,136:137,148]; %P.features
X_train = X_train1(:,ifea);
X_test = X_test1(:,ifea);
clear X_train1 X_test1
% % % Basic: normalizing data
[X_train,X_test] = normalize_data(X_train,X_test);
% % % % -----------------------------------------------
disp(':::::::::::: PNN for FR101')
hiddenLayerSize = 5;
net = patternnet(hiddenLayerSize);
net.trainParam.epochs = 10;
net.trainParam.goal=1e-6;
Wc = [sum(L_tr(1,:)),sum(L_tr(2,:)),sum(L_tr(3,:)),sum(L_tr(4,:))]/size(L_tr,2);
Wc = 1./Wc; %to deal with the imbalanced problem among the Classes
[net,tr] = train(net,X_train',L_tr,[],[],Wc');
% Test the Network
Y = net(X_test');
% % % % % ======================================


function [X1,X2] = normalize_data(X1,X2)
nf = size(X1,2);
CNorm = struct('min',{zeros(1,nf)},'max',{zeros(1,nf)});
n1 = size(X1,1); n2 = size(X2,1);
min_x = min(X1);
max_x = max(X1);
ranges = max_x - min_x;
ix = ranges == 0; %Avoiding NaN
max_x(ix) = 1 + min_x(ix);
ranges = max_x - min_x;
% % % % % % % % % % % %
X1 = (X1 - repmat(min_x, n1, 1)) ./ repmat(ranges, n1, 1);
X2 = (X2 - repmat(min_x, n2, 1)) ./ repmat(ranges, n2, 1);
end