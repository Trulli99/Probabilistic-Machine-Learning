%% Exercise 2
% Dataset: https://archive.ics.uci.edu/ml/datasets/Challenger+USA+Space+Shuttle+O-Ring
clear all; clc; close all;
%The task is to predict the number of O-rings that will experience thermal 
% distress for a given flight when the launch temperature is below freezing.
data = importdata('o-ring-erosion-only.data');
% 1. Number of O-rings at risk on a given flight
% 2. Number experiencing thermal distress
% 3. Launch temperature (degrees F)
% 4. Leak-check pressure (psi)
% 5. Temporal order of flight

Orings = data(1:23,1); % Prediction
fail = data(1:23,2); % input
temperature = data(1:23,3); %input
%pressure = data(1:23,4);
%flight = data(1:23,5);
N = 23;
X_train = [ones(N,1), fail temperature];
W = inv(X_train'*X_train)*X_train'*Orings;
% % Alternatively, W = (X_train'*X_train)\X_train'*Y_train;
yhat = W'*X_train'; % estimation on the training set
