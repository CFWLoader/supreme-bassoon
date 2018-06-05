clf;
x = [0:0.05:5];
omega_base = 2 * pi;
plot3 (x, cos(omega_base*x), sin(omega_base*x), 
  x, 2*cos(2*omega_base*x), 2*sin(2*omega_base*x),
  x, cos(omega_base*x) + 2*cos(2*omega_base*x), sin(omega_base*x) + 2*sin(2*omega_base*x)
);
legend ("e^ix=cos(x)+isin(x)");
title ("Euler");