%% Exercise 2
% Dataset: https://archive.ics.uci.edu/ml/datasets/Container+Crane+Controller+Data+Set
clear all; clc; close all;

speed = [1 2 3 1 2 6 7 6 7 6 8 9 10 8 9]'; % X1 train
angle = [-5 5 -2 2 0 -5 5 -2 2 0 -5 5 -2 2 0]'; %X2 train
power = [0.3 0.3 0.5 0.5 0.7 0.5 0.5 0.3 0.3 0.7 0.5 0.5 0.3 0.3 0.5]'; %Y train

N = 15;
X_train = [ones(N,1), speed angle];
W = inv(X_train'*X_train)*X_train'*power;
% Alternatively, W = (X_train'*X_train)\X_train'*Y_train;
yhat = W'*X_train'; % estimation on the training set


error_sse_array = sum((yhat-power).^2);
error_rms_array = sqrt(error_sse_array./N);

figure;
plot(1:15,power,'o');
hold on
plot(1:15,yhat,'o');
legend('power','yhat')
% xlabel('order M') 
% ylabel('RMS Error') 
