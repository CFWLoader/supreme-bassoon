% X = linspace(-100,100,10);
X = 3:0.001:3.1;
% Y = linspace(-100,100,10);
Y = 4:0.001:4.1;
[ XX, YY ] = meshgrid(X,Y);

% disp(X)

% disp(XX)

% disp((XX - 1) * -0.9438303456504559);

% ZZ1 = 1 - XX - YY;
% ZZ2 = 4/3 - 2/3 * XX + 1/3 *YY;

ZZ1 = 5000 * (gammaln(XX + YY) - gammaln(XX) - gammaln(YY) + (XX - 1) * -0.9438303456504559) + (YY - 1) * -3089.3540767901554;

% [mxVal, lidx] = max(ZZ1(:));

% [r c] = find(ZZ1 == mxVal);

% disp(r);

% disp(c);

figure;
hold on;
meshc(XX,YY,ZZ1);
% mesh(3.08, 4.08, mxVal);
% mesh(XX,YY,ZZ2);