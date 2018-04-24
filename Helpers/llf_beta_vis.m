% X = linspace(-100,100,10);

data_source = dlmread("../../csv_data/BetaSynData5K.csv", ",", 1, 0);

% disp(length(data_source));

logSum = sum(log(data_source));

logOneMinusSum = sum(log(1 - data_source));

dataLen = length(data_source);

X = 3.05:0.0001:3.09;
Y = 4.05:0.0001:4.09;
[ XX, YY ] = meshgrid(X,Y);

ZZ = dataLen * (gammaln(XX + YY) - gammaln(XX) - gammaln(YY)) + (XX - 1) * logSum + (YY - 1) * logOneMinusSum;

[mxVal, lidx] = max(ZZ(:));

[r c] = find(ZZ == mxVal);

figure;
hold on;
mesh(XX, YY, ZZ);
text(X(c), Y(r), mxVal, sprintf("(%f,%f,%f)", X(c), Y(r), mxVal));