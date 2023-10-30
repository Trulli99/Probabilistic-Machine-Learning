%% Ex1
clear all; clc;

Y = load('Y.txt');
Labels = load('Labels.txt');

label0 = 0;
label1 = 0;
class0 = 0;
class1 = 0;

for j=1:size(Labels,1)

    %Number of examples per class
    if Labels(j)==0
        label0=label0+1;
    elseif Labels(j)==1
        label1=label1+1;
    end
    %Numbers of predictions per class
    if Y(j)==0
        class0=class0+1;
    elseif Y(j)==1
        class1=class1+1;
    end
end

fprintf('Positive Labels: %d  | Negative Labels: %d \n',label1,label0);
fprintf('Positive Predictions: %d  | Negative Predictions: %d \n',class1,class0);

TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(Y,1)
    if Y(x)==Labels(x) %Prediction is correct
        if Y(x) == 0 %True Negative
            TN=TN+1;
        elseif Y(x) == 1 %True Positive
            TP=TP+1;
        end
    else %Prediction is wrong
        if Y(x) == 0 %False Negative
            FN=FN+1;
        elseif Y(x) == 1 %False Positive
            FP=FP+1;
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
fprintf('Accuracy = %.3f | Balanced Acc. = %.3f\n',acc,ba);
fprintf('F1score = %.3f\n',f1);
fprintf('Precision = %.3f\n',pre);
fprintf('Recall = TP rate = %.3f\n',rec);

%% Ex2
clear all; clc;

Y = load('Y2.txt');
Labels = load('Labels2.txt');

label0 = 0;
label1 = 0;
class0 = 0;
class1 = 0;

for j=1:size(Labels,1)

    %Number of examples per class
    if Labels(j)==0
        label0=label0+1;
    elseif Labels(j)==1
        label1=label1+1;
    end
    %Numbers of predictions per class
    if Y(j)==0
        class0=class0+1;
    elseif Y(j)==1
        class1=class1+1;
    end
end

fprintf('Positive Labels: %d  | Negative Labels: %d \n',label1,label0);
fprintf('Positive Predictions: %d  | Negative Predictions: %d \n',class1,class0);

TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(Y,1)
    if Y(x)==Labels(x) %Prediction is correct
        if Y(x) == 0 %True Negative
            TN=TN+1;
        elseif Y(x) == 1 %True Positive
            TP=TP+1;
        end
    else %Prediction is wrong
        if Y(x) == 0 %False Negative
            FN=FN+1;
        elseif Y(x) == 1 %False Positive
            FP=FP+1;
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
fprintf('Accuracy = %.3f | Balanced Acc. = %.3f\n',acc,ba);
fprintf('F1score = %.3f\n',f1);
fprintf('Precision = %.3f\n',pre);
fprintf('Recall = TP rate = %.3f\n',rec);

