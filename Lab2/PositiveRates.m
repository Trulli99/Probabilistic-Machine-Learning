function [TPrate,FPrate, TNrate] = PositiveRates(X1,thrx1,Labels)
TP=0;
TN=0;
FP=0;
FN=0;
for x=1:size(X1,1)
    if Labels(x) == 0 % Negative Label
        if X1(x) < thrx1 %True Negative
            TN=TN+1;
        else %False Positive
            FP=FP+1;
        end
    else %Prediction is wrong
        if X1(x) < thrx1 %False Negative
            FN=FN+1;
        else %True Positive
            TP=TP+1;
        end
    end
end
TPrate = TP/(TP+FN);
FPrate = FP/(FP+TN);
TNrate = TN/(TN+FP);
end