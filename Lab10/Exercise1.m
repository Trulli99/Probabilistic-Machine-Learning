%% LAB 10 - Exercise 1
clc; clear all; close all;

%% Alínea a)
load("IDOL_exp1.mat");
labels = Ytest1.label; % Labels on a test set
likehood = Ytest1.like;

%number of examples per class
classes = unique(labels);
class1 = sum(labels(:) == 1);
class2 = sum(labels(:) == 2);
class3 = sum(labels(:) == 3);
class4 = sum(labels(:) == 4);
class5 = sum(labels(:) == 5);

%% Alínea b)
% figure(1); cla; hold on
% gcolor = ['r','k','b','g','m'];
% for i=1:size(labels,1)
%     plot(i,labels(i),'o','Color',gcolor(labels(i)));
% end

%% Alínea c)
TP = zeros(1,5); FP = zeros(1,5);
FN = zeros(1,5); TN = zeros(1,5);
predicted = [];

for i=1:size(likehood,1)
    [~,idx] = max(likehood(i,:));
    predicted=[predicted;idx];
    if labels(i) == idx
        TP(idx) = TP(idx)+1;
    else
        FP(idx) = FP(idx)+1;
    end

    if (labels(i) == 1 && idx ~= 1)
        FN(1) = FN(1)+1;
    elseif (labels(i) == 2 && idx ~= 2)
        FN(2) = FN(2)+1;
    elseif (labels(i) == 3 && idx ~= 3)
        FN(3) = FN(3)+1;
    elseif (labels(i) == 4 && idx ~= 4)
        FN(4) = FN(4)+1;
    elseif (labels(i) == 5 && idx ~= 5)
        FN(5) = FN(5)+1;
    end

    if (labels(i) ~= 1 && idx ~= 1)
        TN(1) = TN(1)+1;
    end
    if (labels(i) ~= 2 && idx ~= 2)
        TN(2) = TN(2)+1;
    end
    if (labels(i) ~= 3 && idx ~= 3)
        TN(3) = TN(3)+1;
    end
    if (labels(i) ~= 4 && idx ~= 4)
        TN(4) = TN(4)+1;
    end
    if (labels(i) ~= 5 && idx ~= 5)
        TN(5) = TN(5)+1;
    end
end
count = size(classes,1);
TPR = TP./(TP+FN)
TNR = TN./(TN+FN)
Pre = TP./(TP+FP)
Recall = TP./(TP+FN)
Acc = sum(TP)/size(labels, 1)
BAcc = sum(TPR)/count
APrecision = sum(Pre)/size(Pre,2)
ARecall = sum(TPR)/size(TPR,2)

fprintf("TP1: %d TP2: %d TP3: %d TP4: %d TP5: %d\n",TP);
fprintf("FP1: %d FP2: %d FP3: %d FP4: %d FP5: %d\n",FP);

%% Alínea d)
% figure(2)
% confusionchart(labels,predicted)

%% Alínea e)
figure(3); cla; hold on
gcolor = ['r','k','b','g','m'];
for i=1:size(predicted,1)
    plot(i,predicted(i),'o','Color',gcolor(labels(i)));
end
