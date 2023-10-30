%% Exercise 2
clear;clc; close all;

x = 0:0.1:10;
mu = 3.9; sig = 0.8;
y = normpdf(x,mu,sig); %  1/sqrt(2*pi*sig^2))*exp(-0.5/sig^2*(x - mu).^2)
figure;
plot(x,y);

%% Alínea b)
sig1 = sqrt(sig); %because of the "normpdf" convention

% First moment
myfun_m1 = @(x,mu,sig) x .* exp(-((x-mu).^2)/(2*sig.^2)) / (sig*sqrt(2*pi));
M1 = integral(@(x) myfun_m1(x, mu, sig1), 0, 10) % For a normal distribution M1 = mu

% Second moment
myfun_m2 = @(x,mu,sig) (x.^2).* exp(-((x-mu).^2)/(2*sig.^2)) / (sig*sqrt(2*pi));
M2 = integral(@(x) myfun_m2(x, mu, sig1), -inf, inf) % For a normal distribution M2 = M1^2 + var(sig)

% 2nd Central moment or Variance = sig
CM2 = M2 - M1^2 % CM2 = sig = 0.8

%% Alínea c)
dx = 0.01;
x = 0:dx:10;
n = length(x); y = zeros(1,n);
% % Let's define an interval
a = 2; b = 5;
x_interval = [2,5];
PDF = 1/(5 - 2);
ix1 = find(x == a); ix2 = find(x == b);
y(ix1:ix2) = PDF;
figure; cla; hold on
ylabel('pdf'); xlabel('x');
plot(x,y,'-b','LineWidth',1,'MarkerSize',2)

% First Moment
M1c = (b+a)/2

% Second Moment
M2c = (b^3 - a^3)/(3*(b-a))

% 2nd Central moment or Variance
CM2c = (b-a)^2 /12
