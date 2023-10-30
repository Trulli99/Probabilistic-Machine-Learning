clc; clear;close all;
addpath('libsvm-3.3/matlab/')  

load IDOL_testset.mat 
load IDOL_trainingset.mat

SVM_par = '-s 0 -t 0 -e 0.01 -m 4000 -b 0 -q';
[normDataTrain,normDataTest] = normalizeData(Xtr.data,Xte.data);
C_model = svmtrain(Xtr.label,normDataTrain,SVM_par);
[Yhat, acc1, Ylike] = svmpredict(Xtr.label, normDataTrain, C_model);

figure()
subplot(2,2,1)
histogram(Ylike(Xtr.label == 5,1),20,"Normalization","probability")
title("5 vs 4")
hold on
histogram(Ylike(Xtr.label == 4,1),20,"Normalization","probability")

subplot(2,2,2)
histogram(Ylike(Xtr.label == 5,2),20,"Normalization","probability")
title("5 vs 2")
hold on
histogram(Ylike(Xtr.label == 2,2),20,"Normalization","probability")

subplot(2,2,3)
histogram(Ylike(Xtr.label == 5,3),20,"Normalization","probability")
title("5 vs 1")
hold on
histogram(Ylike(Xtr.label == 1,3),20,"Normalization","probability")

subplot(2,2,4)
histogram(Ylike(Xtr.label == 5,4),20,"Normalization","probability")
title("5 vs 3")
hold on
histogram(Ylike(Xtr.label == 3,4),20,"Normalization","probability")

figure()
confusionchart(Xtr.label,Yhat)