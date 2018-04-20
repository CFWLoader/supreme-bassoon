data_source = dlmread("../csv_data/AQI.csv", ",", 1, 0);

% disp(length(data_source));

logSum = sum(log(data_source));

% logOneMinusSum = sum(log(1 - data_source));

dataLen = length(data_source);

%X = 1:0.01:100;
%Y = 1:0.01:100;
X = linspace(80, 100, 10);
Y = linspace(1, 3, 12);

xlen = length(X);
ylen = length(Y);

[ XX, YY ] = meshgrid(X,Y);

ZZ = XX;

for xidx = 1:1:xlen
  for yidx = 1:1:ylen
    b = Y(yidx);
    %ZZ(xidx, yidx) = dataLen * (log(Y(yidx)) - Y(yidx) * log(X(xidx))) + (Y(yidx) - 1) * logSum - sum(power(data_source / X(xidx), Y(yidx)));
    powSum = sum(power(data_source, b));
    powLogSum = sum(power(data_source, b).*log(data_source));
    %{
    powLogSum = 0;
    b = Y(yidx);
    for dataIdx = 1:1:dataLen
      dataVal = data_source(dataIdx);
      powLogSum = powLogSum + power(dataVal, b) * log(dataVal);
      powSum = powSum + power(dataVal, b);
    endfor
    %}
    ZZ(yidx, xidx) = (1 / Y(yidx)) + (logSum / dataLen) - (powLogSum / powSum);
  endfor
endfor

disp(ZZ);

%{
mxVal = max(ZZ(:));

[r, c] = find(ZZ == mxVal);

display(X(r));

display(Y(c));
%}

%{
scale = max(ZZ(:));
scale_neg = min(ZZ(:));

if abs(scale_neg) > scale
  scale = abs(scale_neg);
endif
%}

% ZZ = ZZ / scale;

% ZZ = dataLen * (log(YY) - YY * log(XX)) + (YY - 1) * logSum - sum(power(data_source, YY));

%ZZ = dataLen * (gammaln(XX + YY) - gammaln(XX) - gammaln(YY)) + (XX - 1) * logSum + (YY - 1) * log;

%[mxVal, lidx] = max(ZZ(:));

%[r c] = find(ZZ == mxVal);


figure;
hold on;
mesh(XX, YY, ZZ);

%text(X(r), Y(c), mxVal, sprintf("(%f,%f,%f)", X(r), Y(c), mxVal));