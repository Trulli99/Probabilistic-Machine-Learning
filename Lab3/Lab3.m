%% Exercise 1
clear;clc; close all;
X1 = load('X1.txt'); % Supervised classifier
Labels = load('Labels.txt'); % Ground truth

%% Alínea a)
% X1norm = zeros(size(X1,1),size(X1,2));
% for i=1:size(X1,1)
%     X1norm(i) = 1/(1+ exp(-X1(i)));
% end
X1norm = normalize(X1);
thrx1 = 0.5;

Positive = X1norm(X1norm>0.5);
Negative = X1norm(X1norm<=0.5);

nbins = 100;
figure;
histogram(Positive,nbins,'FaceColor','b');
hold on
h = histogram(Negative,nbins,'FaceColor','r');

%% Alínea b)
Xneg = Negative;

Npdf = fitdist(Xneg,'Normal');
y = pdf(Npdf,Xneg);
figure;
plot(Xneg,y,'or');
grid

%% Alínea c)
figure; cla
H = histogram(Xneg,nbins,'Normalization','probability');
hold on
plot(Xneg,y,'or'); % from (b)

%% Alínea d)
nneg = size(Xneg,1);

h_values = h.Values/nneg;
H_values = H.Values;
H_values-h_values