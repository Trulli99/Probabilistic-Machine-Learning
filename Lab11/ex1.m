clear; clc;
addpath('libsvm-3.3/matlab/')  

load IDOL_testset.mat 
load IDOL_trainingset.mat

SVM_par = '-s 0 -t 0 -e 0.01 -m 4000 -b 1 -q';
[normDataTrain,normDataTest] = normalizeData(Xtr.data,Xte.data);
C_model = svmtrain(Xtr.label,normDataTrain,SVM_par);

[Yhat, acc1, Ylike] = svmpredict(Xte.label,normDataTest , C_model,'-b 1');
figure(1)
confusionchart(Xte.label,Yhat)
