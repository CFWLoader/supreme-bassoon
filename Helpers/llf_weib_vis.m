data_source = dlmread("../../csv_data/AQI.csv", ",", 1, 0);

function powGammaSum = weibull_power_sum(beta, gamma, data_sample)
  
  dataLen = length(data_sample);
  
  powGammaSum = 0;
  
  for dataIdx = 1:1:dataLen
      powGammaSum = powGammaSum + power(data_sample(dataIdx) / beta, gamma);
  endfor
  
endfunction

dataLen = length(data_source);

X = linspace(70, 130, 20);
Y = linspace(2, 3, 20);

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
    pow_gam_sum = weibull_power_sum(a, b, data_source);
    %ZZ(xidx, yidx) = dataLen * (log(Y(yidx)) - Y(yidx) * log(X(xidx))) + (Y(yidx) - 1) * logSum - sum(power(data_source / X(xidx), Y(yidx)));
    % powSum = sum(power(data_source, b));
    % powLogSum = sum(power(data_source, b).*log(data_source));
    % ZZ(yidx, xidx) = (1 / Y(yidx)) + (logSum / dataLen) - (powLogSum / powSum);
    ZZ(yidx, xidx) = dataLen * (log(b) - b * log(a)) - pow_gam_sum + (b - 1) * ln_sum;
  endfor
endfor

% disp(ZZ);

mxVal = max(ZZ(:));

[r, c] = find(ZZ == mxVal);

figure;
hold on;
mesh(XX, YY, ZZ);
xlabel('Beta');
ylabel('Gamma');
zlabel('Log Likelihood');

mxx = X(c);
mxy = Y(r);
mxz = mxVal;

text(mxx, mxy, mxz, sprintf("B: %f, G: %f, LL: %f", mxx, mxy, mxz));