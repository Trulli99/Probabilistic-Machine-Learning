function [erro_sse, erro_rms, w] = get_errors(m, data_x, data_y)
if m == 0
    A = [data_x.^0'];
    zh = [data_x.^0];
elseif m == 1
    A = [data_x.^0' data_x.^1'];
    zh = [data_x.^0; data_x.^1];
elseif m == 2
    A = [data_x.^0' data_x.^1' data_x.^2'];
    zh = [data_x.^0; data_x.^1; data_x.^2];
elseif m == 3
    A = [data_x.^0' data_x.^1' data_x.^2' data_x.^3'];
    zh = [data_x.^0; data_x.^1; data_x.^2; data_x.^3];
elseif m == 4
    A = [data_x.^0' data_x.^1' data_x.^2' data_x.^3' data_x.^4'];
    zh = [data_x.^0; data_x.^1; data_x.^2; data_x.^3; data_x.^4];
elseif m == 5
    A = [data_x.^0' data_x.^1' data_x.^2' data_x.^3' data_x.^4' data_x.^5'];
    zh = [data_x.^0; data_x.^1; data_x.^2; data_x.^3; data_x.^4; data_x.^5];
elseif m == 6
    A = [data_x.^0' data_x.^1' data_x.^2' data_x.^3' data_x.^4' data_x.^5' data_x.^6'];
    zh = [data_x.^0; data_x.^1; data_x.^2; data_x.^3; data_x.^4; data_x.^5; data_x.^6];
end

w = A\data_y.';
yh = w.'*zh;
% W = polyfit(data_x, data_y, m);
% yhat = polyval(W,data_x);

erro_sse = sum((yh - data_y).^2);
erro_rms = sqrt(erro_sse/size(data_x, 1));
end