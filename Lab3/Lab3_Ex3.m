%% Exercise 3
clear;clc; close all;

n=[1,2,10,50]; ns = 500;

for i=1:length(n)
    x = unifrnd(0,10,[n(i),ns]); % interval [0,10]
    %x = 0 + (10-0).*rand(ns,1); % Alternative
 
    % Calculate the mean of each sample
    Xbar = mean(x);
    if n(i)<2, Xbar = x; end
    figure;
    histfit(Xbar); % Plot histogram with superimposed Normal
end
