%% Exercicio 2
X1 = load('X1.txt'); % Supervised classifier
X2 = load('X2.txt');
Labels = load('Labels.txt');
X1norm = normalize(X1,'range');

X3avg = zeros(1400,1);
X3max = zeros(1400,1);
X3min = zeros(1400,1);

%Average
for i = 1:1:size(X1,1)
    X3avg(i) = (X1norm(i)+X2(i))/2;
end
[TPr3avg,FPr3avg,TNr3avg] = PositiveRates(X3avg,0.5,Labels);
BA3avg = (TPr3avg+TNr3avg)/2

%Min
for i = 1:1:size(X1,1)
    X3min(i) = min(X1norm(i)+X2(i));
end
[TPr3min,FPr3min,TNr3min] = PositiveRates(X3min,0.5,Labels);
BA3min = (TPr3min+TNr3min)/2

%Max
for i = 1:1:size(X1,1)
    X3max(i) = max(X1norm(i)+X2(i));
end

[TPr3max,FPr3max,TNr3max] = PositiveRates(X3max,0.5,Labels);
BA3max = (TPr3max+TNr3max)/2
%% Exercicio 3
TPr = zeros(21,1);
FPr = zeros(21,1);
j = 1;
for i = 0:0.05:1
    [TPr(j),FPr(j)] = PositiveRates(X1norm,i,Labels);
    j = j + 1;
end
figure;
plot(FPr,TPr);
%% Alínea b

TPr2 = zeros(21,1);
FPr2 = zeros(21,1);
j = 1;
for i = 0:0.05:1
    [TPr2(j),FPr2(j)] = PositiveRates(X2,i,Labels);
    j = j + 1;
end
figure;
plot(FPr2,TPr2);

%% Alínea c

AUCx1 = -1*trapz(FPr,TPr)
AUCx2 = -1*trapz(FPr2,TPr2)
