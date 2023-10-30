%% Lab6 - Exercise 1
close all; clear all; clc;

% % % Ionosphere dataset (in MATLAB)
D = importdata('ionosphere.data');
N = size(D,1); %351
X = zeros(N,35); %34 features plus the GT
for i=1:N
    n = length(D{i});
    X(i,1:34) = str2num(D{i}(1:n-1));
    if D{i}(n) == 'g' X(i,35) = 1; end
end

LabelTraining = X(1:200,:);
LabelTest = X(201:end,:);

% figure(1); histogram(LabelTraining,2)
% figure(2); histogram(LabelTest,2)

%% Alínea c)
%Feature 2 is irrelevant because is always the same
%Feature 1
LabelTraining = LabelTraining(:,3:end);
LabelTest = LabelTest(:,3:end);

%% Alínea d)
% bad-c0 good-c1
c0 = LabelTraining(:,end) == 0;
classB = LabelTraining(c0,1:end-1);

c1 = LabelTraining(:,end) == 1;
classG = LabelTraining(c1,1:end-1);

MuB = mean(classB);
MuG = mean(classG);

%% Alínea e)
% Variance
varB = var(classB);
varG = var(classG);

%% Alínea f)
% Diagonal Covariance Matrix
DcovB = (varB).*eye(32,32);
DcovG = (varG).*eye(32,32);

%% Exercise 2
%% Alínea a)

PC1 = 0.5; PC2 = 1 - PC1;

% Multivariate Bayes classifier with normal distribution
for i=1:size(LabelTest,1)
    Likeb = mvnpdf(LabelTest(i,1:32),MuB,DcovB);
    Likeg = mvnpdf(LabelTest(i,1:32),MuG,DcovG);
    N = Likeb*PC1 + Likeg*PC2; % p(x) = sum(p(x|Ck)*P(Ck))
    Postb(i) = Likeb*PC1/N; % P(Ck|x) = p(x|Ck).P(Ck) / p(x)
    Postg(i) = Likeg*PC2/N;
end

predictions = (Postg>Postb)';

TP = 0;
FP = 0;
TN = 0;
FN = 0;
for i = 1:size(LabelTest,1)
    if LabelTest(i,end) == predictions(i) %Prediction is correct
        if predictions(i) == 0 %True Negative
            TN=TN+1;
        elseif predictions(i)== 1 %True Positive
            TP=TP+1;
        end
    else %Prediction is wrong
        if predictions(i) == 0 %False Negative
            FN=FN+1;
        elseif predictions(i) == 1 %False Positive
            FP=FP+1;
        end
    end

end

fprintf('********** Classifier Normal Bayes\n');
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

%Naive Bayes Classifier 

% Sum of Logs
for i=1:size(LabelTest,1)
    % % % ------------------------- LOG
    Like1 = 0; Like2 = 0;
    for j=1:size(LabelTest,2)-1
        Like1 = Like1 + log( normpdf(LabelTest(i,j),MuB(j),varB(j)) );
        Like2 = Like2 + log( normpdf(LabelTest(i,j),MuG(j),varG(j)) );
    end
    Scaling = Like1+log(PC1) + Like2+log(PC2);
    NBC_B(i) = Like1+log(PC1)/Scaling;
    NBC_G(i) = Like2+log(PC2)/Scaling;
end

% NBC Product
% for i=1:size(LabelTest,1)
% 
%     LikeB = 1;
%     LikeG = 1;
%     for j = 1:size(LabelTest,2)-1
%         LikeB=LikeB*normpdf(LabelTest(i,j),MuB(j),varB(j));
%         LikeG=LikeG*normpdf(LabelTest(i,j),MuG(j),varG(j));
%     end
% 
%     N = LikeB * PC1 + LikeG * PC2;
%     NBC_B(i) = LikeB*PC1/N;
%     NBC_G(i) = LikeG*PC2/N;
% end

predictions = (NBC_G>NBC_B)';

TP = 0;
FP = 0;
TN = 0;
FN = 0;
for i = 1:size(LabelTest,1)
    if LabelTest(i,end) == predictions(i) %Prediction is correct
        if predictions(i) == 0 %True Negative
            TN=TN+1;
        elseif predictions(i)== 1 %True Positive
            TP=TP+1;
        end
    else %Prediction is wrong
        if predictions(i) == 0 %False Negative
            FN=FN+1;
        elseif predictions(i) == 1 %False Positive
            FP=FP+1;
        end
    end

end

fprintf('\n********** NBC\n');
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
