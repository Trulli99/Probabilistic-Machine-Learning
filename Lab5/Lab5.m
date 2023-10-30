%% Lab 5
clc; clear all; close all;
%% Exercise 1
Xtest = readmatrix("Xtest.txt");
Ytest = readmatrix("Ytest.txt");
Xtrain1 = readmatrix("Xtrain1.txt");
Ytrain1 = readmatrix("Ytrain1.txt");
Xtrain2 = readmatrix("Xtrain2.txt");
Ytrain2 = readmatrix("Ytrain2.txt");
%% Alínea a)
% figure;
% subplot(1,2,1);
% plot(Xtrain1,Ytrain1,"o");
% grid on
% xlabel('input - x') 
% ylabel('target - Ytrain1') 
% subplot(1,2,2); 
% plot(Xtrain2,Ytrain2,"o");
% xlabel('input - x') 
% ylabel('target - Ytrain2') 
% grid on

%% Alínea b)
y = sin(2*pi.*Xtrain1) + 0.1*cos(10*pi*Xtrain1);
% figure;
% plot(Xtrain1,Ytrain1,"o");
% grid on
% xlabel('input - x') 
% ylabel('target - Ytrain1') 
% hold on
% plot(Xtrain1,y,"*");

%% Alínea c)

Wtrain1=zeros(10,10);
Wtrain2=zeros(10,10);
error_sse_array = [];
error_rms_array = [];
error_rms_array_test = [];

for M=0:1:9
    Wtrain1(M+1,1:M+1) = polyfit(Xtrain1,Ytrain1,M);
    yhat = polyval(Wtrain1(M+1,1:M+1),Xtrain1);
    error_sse_array(M+1) = sum((yhat-Ytrain1).^2);
    error_rms_array(M+1) = sqrt(error_sse_array(M+1)/size(Xtrain1,1));
    yhat = polyval(Wtrain1(M+1,1:M+1), Xtest);
    error_sse = sum((yhat-Ytest).^2);
    error_rms_array_test(M+1) = sqrt(error_sse/size(Xtest,1));
end

% figure;
% 
% plot(1:1:10,error_rms_array_test);
% title("Training 1")
% xlabel('order M') 
% ylabel('RMS Error') 
% hold on
% plot(1:1:10,error_rms_array);
% legend("Test","Training")

error_sse_array2 = [];
error_rms_array2 = [];
error_rms_array_test2 = [];

for M=0:1:9
    Wtrain2(M+1,1:M+1) = polyfit(Xtrain2,Ytrain2,M);
    yhat = polyval(Wtrain2(M+1,1:M+1),Xtrain2);
    error_sse_array2(M+1) = sum((yhat-Ytrain2).^2);
    error_rms_array2(M+1) = sqrt(error_sse_array2(M+1)/size(Xtrain2,1));
    yhat = polyval(Wtrain2(M+1,1:M+1), Xtest);
    error_sse = sum((yhat-Ytest).^2);
    error_rms_array_test2(M+1) = sqrt(error_sse/size(Xtest,1));
end

% figure;
% plot(1:1:10,error_rms_array_test2);
% title("Training 2")
% xlabel('order M') 
% ylabel('RMS Error') 
% hold on
% plot(1:1:10,error_rms_array2);
% legend("Test","Training")