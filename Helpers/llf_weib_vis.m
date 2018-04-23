data_source = dlmread("../../csv_data/AQI.csv", ",", 1, 0);

% disp(length(data_source));

logSum = sum(log(data_source));

% logOneMinusSum = sum(log(1 - data_source));

dataLen = length(data_source);

%X = 1:0.01:100;
%Y = 1:0.01:100;
X = linspace(60, 100, 20);
Y = linspace(5, 2, 40);

xlen = length(X);
ylen = length(Y);

[ XX, YY ] = meshgrid(X,Y);

ZZ = XX;

%{
weight = len(source_data)

        pow_gam_ln_sum = 0

        ln_sum = 0

        for val in source_data:

            pow_gam_ln_sum = pow_gam_ln_sum + ((val / a)**b)

            ln_sum = ln_sum + math.log(val)

        return weight * (math.log(b) - b * math.log(a)) - pow_gam_ln_sum + (b - 1) * ln_sum
%}

ln_sum = sum(log(data_source));

for xidx = 1:1:xlen
  for yidx = 1:1:ylen
    b = Y(yidx);
    a = X(xidx);
    pow_gam_sum = 0;
    %ZZ(xidx, yidx) = dataLen * (log(Y(yidx)) - Y(yidx) * log(X(xidx))) + (Y(yidx) - 1) * logSum - sum(power(data_source / X(xidx), Y(yidx)));
    % powSum = sum(power(data_source, b));
    % powLogSum = sum(power(data_source, b).*log(data_source));
    %{
    % powLogSum = 0;
    
    for dataIdx = 1:1:dataLen
      % dataVal = data_source(dataIdx);
      % powLogSum = powLogSum + power(dataVal, b) * log(dataVal);
      % powSum = powSum + power(dataVal, b);
      pow_gam_sum = pow_gam_sum + power(data_source(dataIdx) / a, b);
    endfor
    %}
    % ZZ(yidx, xidx) = (1 / Y(yidx)) + (logSum / dataLen) - (powLogSum / powSum);
    ZZ(yidx, xidx) = dataLen * (log(b) - b * log(a)) - pow_gam_sum + (b - 1) * ln_sum;
  endfor
endfor

% disp(ZZ);

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
xlabel('Beta');
ylabel('Gamma');
zlabel('Log Likelihood');

% pause;

%text(X(r), Y(c), mxVal, sprintf("(%f,%f,%f)", X(r), Y(c), mxVal));