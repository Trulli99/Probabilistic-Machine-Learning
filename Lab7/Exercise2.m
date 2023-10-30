%% Lab 7 - Exercise 2
clear; close all; clc;

load fisheriris
N = size(meas,1);
nf = size(meas,2);
unique(species);
t=zeros(N,1);
for i=1:N
    if species{i}(4) == 's', t(i) = 1; end
    if species{i}(4) == 'g', t(i) = 2; end
end

X = meas; clear meas species;
% figure(1);cla;histogram(t,3);
% title('Labels dataset');

c1 = t == 0; c2 = t == 1; c3 = t == 2;
x1 = X(c1,:); %class 1
x2 = X(c2,:); %class 2
x3 = X(c3,:); %class 3

%% Feature 1-2
% PC1 = 1/3; PC2 = 1/3; PC3 = 1/3;
% Mu1 = mean(x1); Mu2 = mean(x2); Mu3 = mean(x3);
% Var1 = var(x1); Var2 = var(x2); Var3 = var(x3);
% 
% N = size(X,1);
% NBC1=zeros(1,N); NBC2=zeros(1,N); NBC3=zeros(1,N);
% for i=1:N
%     Like1 = 1; Like2 = 1; Like3 = 1;
%     for j=1:nf-2 % 1-2 -> nf-2 | 1-3->nf-1 | 1-4->nf
%         Like1 = Like1*normpdf(X(i,j),Mu1(j),sqrt(Var1(j)));
%         Like2 = Like2*normpdf(X(i,j),Mu2(j),sqrt(Var2(j)));
%         Like3 = Like3*normpdf(X(i,j),Mu3(j),sqrt(Var3(j)));
%     end
%     Scaling = Like1*PC1 + Like2*PC2 + Like3*PC3;
%     NBC1(i) = Like1*PC1/Scaling;
%     NBC2(i) = Like2*PC2/Scaling;
%     NBC3(i) = Like3*PC3/Scaling;
% end
% 
% Y = X; %test on the Training set
% L = t; %Labels on the "test"
% N = size(Y,1);
% npos1 = sum(c1); npos2 = sum(c2); npos3 = sum(c3);
% TP1 = 0; TP2 = 0; TP3 = 0;
% for i=1:N
%     if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i) & L(i)==0), TP1=TP1+1; end
%     if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i) & L(i)==1), TP2=TP2+1; end
%     if (NBC3(i)>    NBC1(i) & NBC3(i)>NBC2(i) & L(i)==2), TP3=TP3+1; end
% end
% 
% TPr1 = TP1/npos1; TPr2 = TP2/npos2; TPr3 = TP3/npos3;
% FN1 = npos1 - TP1; FN2 = npos2 - TP2; FN3 = npos3 - TP3;
% %FN1 = npos1 -
% Pre1 = TP1/(TP1 + FP1); Pre2 = TP2/(TP2 + FP2);
% Pre3 = TP3/(TP3 + FP3);
% Rec1 = TPr1; Rec2 = TPr2; Rec3 = TPr3;
% Fsc1 = 2*Pre1*Rec1/(Pre1+Rec1);
% Fsc2 = 2*Pre2*Rec2/(Pre2+Rec2);
% Fsc3 = 2*Pre3*Rec3/(Pre3+Rec3);
% 
% disp('********** Feature 1-2 **********');
% fprintf('Pre1 = %1.2f \t',Pre1);
% fprintf('Rec1 = %1.2f \t',Rec1);
% fprintf('F1 = %1.2f \n',Fsc1);
% fprintf('Pre2 = %1.2f \t',Pre2);
% fprintf('Rec2 = %1.2f \t',Rec2);
% fprintf('F2 = %1.2f \n',Fsc2);
% fprintf('Pre3 = %1.2f \t',Pre3);
% fprintf('Rec3 = %1.2f \t',Rec3);
% fprintf('F3 = %1.2f \n',Fsc3);
% % predicted = [];
% % 
% % for i=1:N
% %     if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i)), predicted = [predicted;0]; end
% %     if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i)), predicted = [predicted;1]; end
% %     if (NBC3(i)>NBC1(i) & NBC3(i)>NBC2(i)), predicted = [predicted;2]; end
% % end
% % 
% % C = confusionmat(L,predicted);
% % confusionchart(C)


%% Feature 1-3
PC1 = 1/3; PC2 = 1/3; PC3 = 1/3;
Mu1 = mean(x1); Mu2 = mean(x2); Mu3 = mean(x3);
Var1 = var(x1); Var2 = var(x2); Var3 = var(x3);
N = size(X,1);
NBC1=zeros(1,N); NBC2=zeros(1,N); NBC3=zeros(1,N);
for i=1:N
    Like1 = 1; Like2 = 1; Like3 = 1;
    for j=1:nf-1 % 1-2 -> nf-2 | 1-3->nf-1 | 1-4->nf
        Like1 = Like1*normpdf(X(i,j),Mu1(j),sqrt(Var1(j)));
        Like2 = Like2*normpdf(X(i,j),Mu2(j),sqrt(Var2(j)));
        Like3 = Like3*normpdf(X(i,j),Mu3(j),sqrt(Var3(j)));
    end
    Scaling = Like1*PC1 + Like2*PC2 + Like3*PC3;
    NBC1(i) = Like1*PC1/Scaling;
    NBC2(i) = Like2*PC2/Scaling;
    NBC3(i) = Like3*PC3/Scaling;
end

Y = X; %test on the Training set
L = t; %Labels on the "test"
N = size(Y,1);
npos1 = sum(c1); npos2 = sum(c2); npos3 = sum(c3);
TP1 = 0; TP2 = 0; TP3 = 0; FP1 = 0; FP2 = 0; FP3 = 0;
Yhat = zeros(1,N);
for i=1:N
    if (NBC1(i)>NBC2(i) && NBC1(i)>NBC3(i))
        Yhat(i) = 0;
        if (L(i)==0) TP1=TP1+1;
        else FP1=FP1+1; end
    end
    if (NBC2(i)>NBC1(i) && NBC2(i)>NBC3(i))
        Yhat(i) = 1;
        if (L(i)==1) TP2=TP2+1;
        else FP2=FP2+1; end
    end
    if (NBC3(i)>NBC1(i) && NBC3(i)>NBC2(i))
        Yhat(i) = 2;
        if (L(i)==2) TP3=TP3+1;
        else FP3=FP3+1; end
    end
end

% for i=1:N
%     if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i) & L(i)==0), TP1=TP1+1; end
%     if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i) & L(i)==1), TP2=TP2+1; end
%     if (NBC3(i)>    NBC1(i) & NBC3(i)>NBC2(i) & L(i)==2), TP3=TP3+1; end
% end

TPr1 = TP1/npos1; TPr2 = TP2/npos2; TPr3 = TP3/npos3;
FN1 = npos1 - TP1; FN2 = npos2 - TP2; FN3 = npos3 - TP3;
Pre1 = TP1/(TP1 + FP1); Pre2 = TP2/(TP2 + FP2);
Pre3 = TP3/(TP3 + FP3);
Rec1 = TPr1; Rec2 = TPr2; Rec3 = TPr3;
Fsc1 = 2*Pre1*Rec1/(Pre1+Rec1);
Fsc2 = 2*Pre2*Rec2/(Pre2+Rec2);
Fsc3 = 2*Pre3*Rec3/(Pre3+Rec3);

disp('********** Feature 1-3 **********');
fprintf('Pre1 = %1.2f \t',Pre1);
fprintf('Rec1 = %1.2f \t',Rec1);
fprintf('F1 = %1.2f \n',Fsc1);
fprintf('Pre2 = %1.2f \t',Pre2);
fprintf('Rec2 = %1.2f \t',Rec2);
fprintf('F2 = %1.2f \n',Fsc2);
fprintf('Pre3 = %1.2f \t',Pre3);
fprintf('Rec3 = %1.2f \t',Rec3);
fprintf('F3 = %1.2f \n',Fsc3);

predicted = [];

for i=1:N
    if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i)), predicted = [predicted;0]; end
    if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i)), predicted = [predicted;1]; end
    if (NBC3(i)>NBC1(i) & NBC3(i)>NBC2(i)), predicted = [predicted;2]; end
end

C = confusionmat(L,predicted);
confusionchart(C)

%% Feature 1-4
N = size(X,1);
NBC1=zeros(1,N); NBC2=zeros(1,N); NBC3=zeros(1,N);
for i=1:N
    Like1 = 1; Like2 = 1; Like3 = 1;
    for j=1:nf % 1-2 -> nf-2 | 1-3->nf-1 | 1-4->nf
        Like1 = Like1*normpdf(X(i,j),Mu1(j),sqrt(Var1(j)));
        Like2 = Like2*normpdf(X(i,j),Mu2(j),sqrt(Var2(j)));
        Like3 = Like3*normpdf(X(i,j),Mu3(j),sqrt(Var3(j)));
    end
    Scaling = Like1*PC1 + Like2*PC2 + Like3*PC3;
    NBC1(i) = Like1*PC1/Scaling;
    NBC2(i) = Like2*PC2/Scaling;
    NBC3(i) = Like3*PC3/Scaling;
end

Y = X; %test on the Training set
L = t; %Labels on the "test"
N = size(Y,1);
npos1 = sum(c1); npos2 = sum(c2); npos3 = sum(c3);
TP1 = 0; TP2 = 0; TP3 = 0;
for i=1:N
    if (NBC1(i)>NBC2(i) & NBC1(i)>NBC3(i) & L(i)==0), TP1=TP1+1; end
    if (NBC2(i)>NBC1(i) & NBC2(i)>NBC3(i) & L(i)==1), TP2=TP2+1; end
    if (NBC3(i)>    NBC1(i) & NBC3(i)>NBC2(i) & L(i)==2), TP3=TP3+1; end
end

TPr1 = TP1/npos1; TPr2 = TP2/npos2; TPr3 = TP3/npos3;
FP1 = npos1 - TP1; FP2 = npos2 - TP2; FP3 = npos3 - TP3;
Pre1 = TP1/(TP1 + FP1); Pre2 = TP2/(TP2 + FP2);
Pre3 = TP3/(TP3 + FP3);
Rec1 = TPr1; Rec2 = TPr2; Rec3 = TPr3;
Fsc1 = 2*Pre1*Rec1/(Pre1+Rec1);
Fsc2 = 2*Pre2*Rec2/(Pre2+Rec2);
Fsc3 = 2*Pre3*Rec3/(Pre3+Rec3);

disp('********** Feature 1-4 **********');
fprintf('Pre1 = %1.2f \t',Pre1);
fprintf('Rec1 = %1.2f \t',Rec1);
fprintf('F1 = %1.2f \n',Fsc1);
fprintf('Pre2 = %1.2f \t',Pre2);
fprintf('Rec2 = %1.2f \t',Rec2);
fprintf('F2 = %1.2f \n',Fsc2);
fprintf('Pre3 = %1.2f \t',Pre3);
fprintf('Rec3 = %1.2f \t',Rec3);
fprintf('F3 = %1.2f \n',Fsc3);



