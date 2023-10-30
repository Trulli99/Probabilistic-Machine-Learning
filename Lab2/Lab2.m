%% Exercise 1
clear;clc;
X1 = load('X1.txt'); % Supervised classifier
X2 = load('X2.txt'); % Generative classifier
Labels = load('Labels.txt'); % Ground truth

%% Alinea a)
label0 = 0;
label1 = 0;
class0 = 0;
class1 = 0;

% Classifier X1
thrx1 = 0;
for j=1:size(Labels,1)

    %Number of examples per class
    if Labels(j) == 0 % Negative
         label0=label0+1;
    else % Positive
        label1=label1+1;
    end
    %Numbers of predictions per class
    if X1(j) < thrx1
        class0=class0+1;
    else
        class1=class1+1;
    end
end
fprintf('X1\n');
fprintf('Positive Labels: %d  | Negative Labels: %d \n',label1,label0);
fprintf('Positive Predictions: %d  | Negative Predictions: %d \n',class1,class0);

TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(X1,1)
    if Labels(x) == 0 % Negative Label
        if X1(x) < thrx1 %True Negative
            TN=TN+1;
        else %False Positive
            FP=FP+1;
        end
    else %Prediction is wrong
        if X1(x) < thrx1 %False Negative
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

accx1 = (TP+TN)/(TP+TN+FP+FN);
bax1 = (TPrate+TNrate)/2;
f1 = (2*TP)/(2*TP + FP + FN);
pre = TP/(TP+FP);
rec = TPrate;
fprintf('Accuracy = %.3f | Balanced Acc. = %.3f\n',accx1,bax1);
fprintf('F1score = %.3f\n',f1);
fprintf('Precision = %.3f\n',pre);
fprintf('Recall = TP rate = %.3f\n',rec);

% Classifier X2
thrx2 = 0.5;
label0 = 0;
label1 = 0;
class0 = 0;
class1 = 0;
for j=1:size(Labels,1)

    %Number of examples per class
    if Labels(j) == 0 % Negative
         label0=label0+1;
    else % Positive
        label1=label1+1;
    end
    %Numbers of predictions per class
    if X2(j) < thrx2
        class0=class0+1;
    else
        class1=class1+1;
    end
end
fprintf('\nX2\n');
fprintf('Positive Labels: %d  | Negative Labels: %d \n',label1,label0);
fprintf('Positive Predictions: %d  | Negative Predictions: %d \n',class1,class0);

TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(X2,1)
    if Labels(x) == 0 % Negative Label
        if X2(x) < thrx2 %True Negative
            TN=TN+1;
        else %False Positive
            FP=FP+1;
        end
    else %Prediction is wrong
        if X2(x) < thrx2 %False Negative
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
Xc = X1;
Xc(1:400) = -1;
TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(Xc,1)
    if Labels(x) == 0 % Negative Label
        if Xc(x) < thrx1 %True Negative
            TN=TN+1;
        else %False Positive
            FP=FP+1;
        end
    else %Prediction is wrong
        if Xc(x) < thrx1 %False Negative
            FN=FN+1;
        else %True Positive
            TP=TP+1;
        end
    end
end

accxc = (TP+TN)/(TP+TN+FP+FN);
baxc = (TPrate+TNrate)/2;
fprintf('\n');
fprintf('X1 Accuracy = %.3f | X1 Balanced Acc. = %.3f\n',accx1,bax1);
fprintf('Xc Accuracy = %.3f | Xc Balanced Acc. = %.3f\n',accxc,baxc);

%% Alínea d)

X1norm = normalize(X1,'range');

TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(X1norm,1)
    if Labels(x) == 0 % Negative Label
        if X1norm(x) < thrx2 %True Negative
            TN=TN+1;
        else %False Positive
            FP=FP+1;
        end
    else %Prediction is wrong
        if X1norm(x) < thrx2 %False Negative
            FN=FN+1;
        else %True Positive
            TP=TP+1;
        end
    end
end
fprintf('\nX1 normalized\n')
fprintf('True Positives: %d  | False Positives: %d \n',TP,FP);
fprintf('True Negatives: %d  | False Negatives: %d \n',TN,FN);

TPrate = TP/(TP+FN);
TNrate = TN/(TN+FP);
FPrate = FP/(FP+TN);
FNrate = FN/(FN+TP);
fprintf('TP rate = %.3f | FP rate = %.3f\n',TPrate,FPrate);
fprintf('TN rate = %.3f | FN rate = %.3f\n',TNrate,FNrate);

acc = (TP+TN)/(TP+TN+FP+FN);
ba = (TPrate+TNrate)/2;
f1 = (2*TP)/(2*TP + FP + FN);
pre = TP/(TP+FP);
rec = TPrate;
fprintf('Accuracy = %.3f | Balanced Acc. = %.3f\n',acc,ba);
fprintf('F1score = %.3f\n',f1);
fprintf('Precision = %.3f\n',pre);
fprintf('Recall = TP rate = %.3f\n',rec);

%% Alinea e)

Positive = X1norm(X1norm>0.5);
Negative = X1norm(X1norm<=0.5);

histogram(Positive,'FaceColor','r');
hold on
histogram(Negative,'FaceColor','g');
