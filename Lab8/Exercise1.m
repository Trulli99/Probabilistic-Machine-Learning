%% LAB 8 - Exercise 1
clc; clear; close all;
data = dir(['./fr*set']);
for k=1:3 %3 datasets: fr101, fr52, fr79
    % % % % DATASET
    [X_train1,X_test1] = F_dataset_multiclass(data(k));
    fprintf('\nDataset: %s \n',data(k).name);
    labels = unique(X_train1(:,end))';
    nr_class = length(labels);
    fprintf('nr classes: %d \n',nr_class);
    L_tr = false( nr_class, size(X_train1,1) );
    L_te = false( nr_class, size(X_test1,1) );
    for c=1:nr_class
        ix = X_train1(:,end) == labels(c);
        L_tr(c,ix) = true;
        ix = X_test1(:,end) == labels(c);
        L_te(c,ix) = true;
    end
    % % % ========================= Type of FEATURES:::
    ifea = [3:5,8:9,129:131,136:137,148]; %P.features
    fprintf("nr features: %d\n",size(X_train1,2))
    X_train = X_train1(:,ifea);
    X_test = X_test1(:,ifea);
    fprintf("nr features of the training and testing sets: %d\n",size(X_train,2))
    fprintf("nr training examples: %d\n",size(X_train,1))
    fprintf("nr testing examples: %d\n",size(X_test,1))
    clear X_train1 X_test1
end

%% Alínea b)
k = 2; % fr52 dataset

[X_train1,X_test1] = F_dataset_multiclass(data(k));
labels = unique(X_train1(:,end))';
nr_class = length(labels);
L_tr = false( nr_class, size(X_train1,1) );
L_te = false( nr_class, size(X_test1,1) );
for c=1:nr_class
    ix = X_train1(:,end) == labels(c);
    L_tr(c,ix) = true;
    ix = X_test1(:,end) == labels(c);
    L_te(c,ix) = true;
end
% % % ========================= Type of FEATURES:::
ifea = [3:5,8:9,129:131,136:137,148]; %P.features
X_train = X_train1(:,ifea);
X_test = X_test1(:,ifea);

x1 = X_train(L_tr(1,:),:);
x2 = X_train(L_tr(2,:),:);
x3 = X_train(L_tr(3,:),:);

PC1 = 1/3; PC2 = 1/3; PC3 = 1/3;
Mu1 = mean(x1); Mu2 = mean(x2); Mu3 = mean(x3);
Var1 = var(x1); Var2 = var(x2); Var3 = var(x3);

% Naive Bayes Classifier 
N = size(X_test,1);
NBC1=zeros(1,N); NBC2=zeros(1,N); NBC3=zeros(1,N);
for i=1:N
    Like1 = 1; Like2 = 1; Like3 = 1;
    for j=1:size(X_test,2)
        Like1 = Like1*normpdf(X_test(i,j),Mu1(j),sqrt(Var1(j)));
        Like2 = Like2*normpdf(X_test(i,j),Mu2(j),sqrt(Var2(j)));
        Like3 = Like3*normpdf(X_test(i,j),Mu3(j),sqrt(Var3(j)));
    end
    Scaling = Like1*PC1 + Like2*PC2 + Like3*PC3;
    NBC1(i) = Like1*PC1/Scaling;
    NBC2(i) = Like2*PC2/Scaling;
    NBC3(i) = Like3*PC3/Scaling;
end

Y=X_test;
N = size(Y,1);
npos1 = sum(L_te(1,:)); npos2 = sum(L_te(2,:)); npos3 = sum(L_te(3,:));
TP1 = 0; TP2 = 0; TP3 = 0;
FP1 = 0; FP2 = 0; FP3 = 0;
Yhat = zeros(1,N);
for i=1:N
%     if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i) & L_te(1,i)==1), TP1=TP1+1; end
%     if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i) & L_te(2,i)==1), TP2=TP2+1; end
%     if (NBC3(i)>NBC1(i) & NBC3(i)>NBC2(i) & L_te(3,i)==1), TP3=TP3+1; end
    if (NBC1(i)>NBC2(i) && NBC1(i)>NBC3(i))
        Yhat(i) = 0;
        if (L_te(1,i)==1) TP1=TP1+1;
        else FP1=FP1+1; end
    end
    if (NBC2(i)>NBC1(i) && NBC2(i)>NBC3(i))
        Yhat(i) = 1;
        if (L_te(2,i)==1) TP2=TP2+1;
        else FP2=FP2+1; end
    end
    if (NBC3(i)>NBC1(i) && NBC3(i)>NBC2(i))
        Yhat(i) = 2;
        if (L_te(3,i)==1) TP3=TP3+1;
        else FP3=FP3+1; end
    end
end

TPr1 = TP1/npos1; TPr2 = TP2/npos2; TPr3 = TP3/npos3;
%FP1 = npos1 - TP1; FP2 = npos2 - TP2; FP3 = npos3 - TP3;
FN1 = npos1 - TP1; FN2 = npos2 - TP2; FN3 = npos3 - TP3;

Pre1 = TP1/(TP1 + FP1); Pre2 = TP2/(TP2 + FP2);
Pre3 = TP3/(TP3 + FP3);
Rec1 = TPr1; Rec2 = TPr2; Rec3 = TPr3;
Fsc1 = 2*Pre1*Rec1/(Pre1+Rec1);
Fsc2 = 2*Pre2*Rec2/(Pre2+Rec2);
Fsc3 = 2*Pre3*Rec3/(Pre3+Rec3);
fprintf('\n********** NBC for fr52 dataset **********\n');
fprintf('TPr1: %1.2f\n',TPr1*100);
fprintf('Pre1 = %1.2f \n',Pre1);
fprintf('Rec1 = %1.2f \n',Rec1);
fprintf('F1 = %1.2f \n',Fsc1);
fprintf('TPr2: %1.2f\n',TPr2*100);
fprintf('Pre2 = %1.2f \n',Pre2);
fprintf('Rec2 = %1.2f \n',Rec2);
fprintf('F2 = %1.2f \n',Fsc2);
fprintf('TPr3: %1.2f\n',TPr3*100);
fprintf('Pre3 = %1.2f \n',Pre3);
fprintf('Rec3 = %1.2f \n',Rec3);
fprintf('F3 = %1.2f \n',Fsc3);

%% Alínea c)
k = 1;

[X_train1,X_test1] = F_dataset_multiclass(data(k));
labels = unique(X_train1(:,end))';
nr_class = length(labels);
L_tr = false( nr_class, size(X_train1,1) );
L_te = false( nr_class, size(X_test1,1) );
for c=1:nr_class
    ix = X_train1(:,end) == labels(c);
    L_tr(c,ix) = true;
    ix = X_test1(:,end) == labels(c);
    L_te(c,ix) = true;
end
% % % ========================= Type of FEATURES:::
ifea = [3:5,8:9,129:131,136:137,148]; %P.features
X_train = X_train1(:,ifea);
X_test = X_test1(:,ifea);

x1 = X_train(L_tr(1,:),:);
x2 = X_train(L_tr(2,:),:);
x3 = X_train(L_tr(3,:),:);
x4 = X_train(L_tr(4,:),:);

PC1 = 1/4; PC2 = 1/4; PC3 = 1/4; PC4 = 1/4;
Mu1 = mean(x1); Mu2 = mean(x2); Mu3 = mean(x3); Mu4 = mean(x4);
Var1 = var(x1); Var2 = var(x2); Var3 = var(x3); Var4 = var(x4);

% Naive Bayes Classifier 
N = size(X_test,1);
NBC1=zeros(1,N); NBC2=zeros(1,N); NBC3=zeros(1,N); NBC4=zeros(1,N);
for i=1:N
    Like1 = 1; Like2 = 1; Like3 = 1; Like4 = 1;
    for j=1:size(X_test,2)
        Like1 = Like1*normpdf(X_test(i,j),Mu1(j),sqrt(Var1(j)));
        Like2 = Like2*normpdf(X_test(i,j),Mu2(j),sqrt(Var2(j)));
        Like3 = Like3*normpdf(X_test(i,j),Mu3(j),sqrt(Var3(j)));
        Like4 = Like4*normpdf(X_test(i,j),Mu4(j),sqrt(Var4(j)));
    end
    Scaling = Like1*PC1 + Like2*PC2 + Like3*PC3 + Like4*PC4;
    NBC1(i) = Like1*PC1/Scaling;
    NBC2(i) = Like2*PC2/Scaling;
    NBC3(i) = Like3*PC3/Scaling;
    NBC4(i) = Like4*PC4/Scaling;
end

Y=X_test;
N = size(Y,1);
npos1 = sum(L_te(1,:)); npos2 = sum(L_te(2,:)); npos3 = sum(L_te(3,:)); npos4 = sum(L_te(4,:));
TP1 = 0; TP2 = 0; TP3 = 0; TP4 = 0;
FP1 = 0; FP2 = 0; FP3 = 0; FP4 = 0;
Yhat = zeros(1,N);
for i=1:N
%     if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i) & NBC1(i)>NBC4(i) & L_te(1,i)==1), TP1=TP1+1; end
%     if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i) & NBC2(i)>NBC4(i) & L_te(2,i)==1), TP2=TP2+1; end
%     if (NBC3(i)>NBC1(i) & NBC3(i)>NBC2(i) & NBC3(i)>NBC4(i) & L_te(3,i)==1), TP3=TP3+1; end
%     if (NBC4(i)>NBC1(i) & NBC4(i)>NBC2(i) & NBC4(i)>NBC3(i) & L_te(4,i)==1), TP4=TP4+1; end
    if (NBC1(i)>NBC2(i) && NBC1(i)>NBC3(i) & NBC1(i)>NBC4(i))
        Yhat(i) = 0;
        if (L_te(1,i)==1) TP1=TP1+1;
        else FP1=FP1+1; end
    end
    if (NBC2(i)>NBC1(i) && NBC2(i)>NBC3(i) & NBC2(i)>NBC4(i))
        Yhat(i) = 1;
        if (L_te(2,i)==1) TP2=TP2+1;
        else FP2=FP2+1; end
    end
    if (NBC3(i)>NBC1(i) && NBC3(i)>NBC2(i) & NBC3(i)>NBC4(i))
        Yhat(i) = 2;
        if (L_te(3,i)==1) TP3=TP3+1;
        else FP3=FP3+1; end
    end
    if (NBC4(i)>NBC1(i) & NBC4(i)>NBC2(i) & NBC4(i)>NBC3(i))
        Yhat(i) = 3;
        if (L_te(4,i)==1) TP4=TP4+1;
        else FP4=FP4+1; end
    end
end

TPr1 = TP1/npos1; TPr2 = TP2/npos2; TPr3 = TP3/npos3; TPr4 = TP4/npos4;
%FP1 = npos1 - TP1; FP2 = npos2 - TP2; FP3 = npos3 - TP3; FP4 = npos4 - TP4;
FN1 = npos1 - TP1; FN2 = npos2 - TP2; FN3 = npos3 - TP3; FN4 = npos4 - TP4;
Pre1 = TP1/(TP1 + FP1); Pre2 = TP2/(TP2 + FP2);
Pre3 = TP3/(TP3 + FP3); Pre4 = TP4/(TP4 + FP4);
Rec1 = TPr1; Rec2 = TPr2; Rec3 = TPr3; Rec4 = TPr4;
Fsc1 = 2*Pre1*Rec1/(Pre1+Rec1);
Fsc2 = 2*Pre2*Rec2/(Pre2+Rec2);
Fsc3 = 2*Pre3*Rec3/(Pre3+Rec3);
Fsc4 = 2*Pre4*Rec4/(Pre4+Rec4);
fprintf('\n********** NBC for fr101 dataset **********\n');
fprintf('TPr1: %1.2f\n',TPr1*100);
fprintf('Pre1 = %1.2f \n',Pre1);
fprintf('Rec1 = %1.2f \n',Rec1);
fprintf('F1 = %1.2f \n',Fsc1);
fprintf('TPr2: %1.2f\n',TPr2*100);
fprintf('Pre2 = %1.2f \n',Pre2);
fprintf('Rec2 = %1.2f \n',Rec2);
fprintf('F2 = %1.2f \n',Fsc2);
fprintf('TPr3: %1.2f\n',TPr3*100);
fprintf('Pre3 = %1.2f \n',Pre3);
fprintf('Rec3 = %1.2f \n',Rec3);
fprintf('F3 = %1.2f \n',Fsc3);
fprintf('TPr4: %1.2f\n',TPr4*100);
fprintf('Pre4 = %1.2f \n',Pre4);
fprintf('Rec4 = %1.2f \n',Rec4);
fprintf('F4 = %1.2f \n',Fsc4);

%% Alínea d)
predicted = [];

for i=1:N
    if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i) & NBC1(i)>NBC4(i)), predicted=[predicted;1]; end
    if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i) & NBC2(i)>NBC4(i)), predicted=[predicted;2]; end
    if (NBC3(i)>NBC1(i) & NBC3(i)>NBC2(i) & NBC3(i)>NBC4(i)), predicted=[predicted;3]; end
    if (NBC4(i)>NBC1(i) & NBC4(i)>NBC2(i) & NBC4(i)>NBC3(i)), predicted=[predicted;4]; end
end
L = zeros(1,N);
for j=1:N
    if(L_te(1,j) == 1), L(j) = 1; end
    if(L_te(2,j) == 1), L(j) = 2; end
    if(L_te(3,j) == 1), L(j) = 3; end
    if(L_te(4,j) == 1), L(j) = 4; end
end

C = confusionmat(L,predicted);
confusionchart(C)