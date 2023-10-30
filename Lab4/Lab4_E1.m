%% LAB 4 - Exercise 1
clear;clc; close all;
Y = readmatrix('data_y.txt'); %Training set, output/target variabl
X = [10:2:68]'; %Training set (N=30), input variable
figure;
plot(X,Y,'-o');
title('Graph of training points')
xlabel('X: independent variable');
ylabel('Y: output variable');
%% Alínea b)

m = 2; %ORDER: model of the class polynomial: power(x)
if m == 0
    A = [X.^0']; % build the function matrix
    zh = [X.^0]; % transformed output variable
elseif m == 1
    A = [X.^0' X.^1']; % build the function matrix
    zh = [X.^0; X.^1]; % transformed output variable
elseif m == 2
    A = [X.^0' X.^1' X.^2'];
    zh = [X.^0; X.^1; X.^2];
elseif m == 3
    A = [X.^0' X.^1' X.^2' X.^3'];
    zh = [X.^0; X.^1; X.^2; X.^3];
elseif m == 4
    A = [X.^0' X.^1' X.^2' X.^3' X.^4'];
    zh = [X.^0; X.^1; X.^2; X.^3; X.^4];
elseif m == 5
    A = [X.^0' X.^1' X.^2' X.^3' X.^4' X.^5'];
    zh = [X.^0; X.^1; X.^2; X.^3; X.^4; X.^5];
elseif m == 6
    A = [X.^0' X.^1' X.^2' X.^3' X.^4' X.^5' X.^6'];
    zh = [X.^0; X.^1; X.^2; X.^3; X.^4; X.^5; X.^6];
end

w = A\Y.'; % the operator \ == least.squares in Matlab
yh = w.'*zh; % obtain the estimated Output

W = polyfit(X,Y,m); % using Polyfit
yhat = polyval(W,X);

%Wls = lsqr(A,Y'); %Solve Ax=b using lsqr ie, minimizes norm(b-A*x)

%% Alínea c)

hold on
plot(X,yhat,'r*')
plot(X,yh,'k-')
sum(yh - yhat)

%% Alínea d)

% sum of the squares of the errors (SSE)
Esse = sum((yhat-Y).^2); 

%% Alínea e)

N = size(Y,1);
% Root-mean-square (RMS) error
Erms = sqrt(Esse/N);

%% Alínea f)
% test set
Xtest = [70:2:100]';
Ytest = readmatrix('data_y_test.txt');
N1 = size(Ytest,1);

erro_sse_array_test = [];
erro_rms_array_test = [];

erro_sse_array = [];
erro_rms_array = [];

for M = 0:1:6
    W= polyfit(X,Y,M);
    yhat = polyval(W,X);
    erro_sse_array(M+1) = sum((yhat-Y).^2);
    erro_rms_array(M+1) = sqrt(erro_sse_array(M+1)/N);

    yhat1 = polyval(W,Xtest);
    erro_sse_array_test(M+1) = sum((yhat1-Ytest).^2);
    erro_rms_array_test(M+1) = sqrt(erro_sse_array_test(M+1)/N1);
end

figure;
hold on
M = [0:1:6];
plot(M,erro_rms_array,'DisplayName','Train RMS')
plot(M,log(erro_rms_array_test),'DisplayName','Test RMS')
legend
