%% LAB4 Exercise 2
clear; clc; close all;
X = load("Output.txt");
Labels = load("Labels.txt");

%% Alínea a)

label0 = 0;
label1 = 0;
class0 = 0;
class1 = 0;

% Classifier
thr = 0;
for j=1:size(Labels,1)
    %Number of examples per class
    if Labels(j) == 0 % Negative
         label0=label0+1;
    else % Positive
        label1=label1+1;
    end
    %Numbers of predictions per class
    if X(j) < thr
        class0=class0+1;
    else
        class1=class1+1;
    end
end
%fprintf('X\n');
fprintf('Positive Labels: %d  | Negative Labels: %d \n',label1,label0);
fprintf('Positive Predictions: %d  | Negative Predictions: %d \n',class1,class0);

TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(X,1)
    if Labels(x) == 0 % Negative Label
        if X(x) < thr %True Negative
            TN=TN+1;
        else %False Positive
            FP=FP+1;
        end
    else %Prediction is wrong
        if X(x) < thr %False Negative
            FN=FN+1;
        else %True Positive
            TP=TP+1;
        end
    end
end
fprintf('True Positives: %d  | False Positives: %d \n',TP,FP);
fprintf('True Negatives: %d  | False Negatives: %d \n',TN,FN);

TPrate = TP/(TP+FN);
TNrate = TN/(TN+FP);
FPrate = FP/(FP+TN);
FNrate = FN/(FN+TP);
fprintf('TP rate = %.3f | FP rate = %.3f\n',TPrate,FPrate);
fprintf('TN rate = %.3f | FN rate = %.3f\n',TNrate,FNrate);

%% Alínea b)

acc = (TP+TN)/(TP+TN+FP+FN);
ba = (TPrate+TNrate)/2;
f1 = (2*TP)/(2*TP + FP + FN);
pre = TP/(TP+FP);
rec = TPrate;
fprintf('Accuracy = %.3f | Balanced Acc. = %.3f\n',acc,ba);
fprintf('F1score = %.3f\n',f1);
fprintf('Precision = %.3f\n',pre);
fprintf('Recall = TP rate = %.3f\n',rec);

%% Alínea c)

% Logistic Sigmoid
sig = zeros(size(X,1),size(X,2));
for i=1:size(X,1)
    sig(i) = 1/(1+ exp(-X(i)));
end

% Softplus
soft = zeros(size(X,1),size(X,2));
for i=1:size(X,1)
    soft(i) = log(1+exp(X(i)));
end

% ReLu
relu = zeros(size(X,1),size(X,2));
for i=1:size(X,1)
    relu(i) = max(0,X(i));
end

%% Alínea d)

size = size(X,1)/4;
validation = zeros(4,size);
train = zeros(4,3*size);
j=1;
for i=1:1:4
    validation(i,:) = X(j:i*size,1)';
    j = j + size;
    if i == 1
        train(i,:) = X(size:(size*4)-1,1)';
    elseif i == 2
        train(i,1:size) = X(1:size,1)';
        train(i,size+1:3*size) = X(size*2:(size*4)-1,1)';
    end
end