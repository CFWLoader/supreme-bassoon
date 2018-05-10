# Parameters Estimation

## Tricks

When the first derivative is too difficult to be derived or to complex. We can use the definition of derivative:

$$
f'(x) = \frac{df(x)}{dx} = \frac{f(x + \Delta x) - f(x)}{\Delta x}
$$

where $\Delta x$ can be set small enough that we can accept.

## MLE for Kumaraswamy

### Probability Density Function

$$
f(x; a, b) = abx^{a-1}(1-x^a)^{b-1}, ~~ x\in[0,1]
$$

### Cumulative Density Function

$$
F(x; a, b) = 1-(1-x^a)^{b}, ~~ x\in[0,1]
$$

### Likelihood Function

$$
L(a, b; X) = \prod_{i=1}^N [abx_i^{a-1}(1-x_i^a)^{b-1}]
$$

### Log-Likelihood Function

$$
\ell(a, b; X) = Nln(a) + Nln(b) + (a-1)\sum_{i=1}^N ln(x_i) + (b - 1)\sum_{i=1}^N ln(1-x_i^a)
$$

### First Derivatives

$$
\begin{align}
\frac{\partial \ell}{\partial a} & = \frac{N}{a} + \sum_{i=1}^N ln(x_i) - (b - 1) \sum_{i=1}^N \frac{x_i^a lnx_i}{1-x_i^a} \\
\frac{\partial \ell}{\partial b} & = \frac{N}{b} + \sum_{i=1}^N ln(1-x_i^a)
\end{align}
$$

### Second Derivatives

$$
\begin{align}
\frac{\partial \ell^2}{\partial^2 a} & = - \frac{N}{a^2} - (b -1) \sum_{i=1}^N x_i^a (\frac{lnx_i}{1-x_i^a})^2 \\

\frac{\partial \ell^2}{\partial a \partial b} & = \frac{\partial \ell^2}{\partial b \partial a} = - \sum_{i=1}^{N} \frac{x_i^a lnx_i}{1-x_i^a} \\

\frac{\partial \ell^2}{\partial^2 b} & = -\frac{N}{b^2}
\end{align}
$$

A [paper](https://www.tandfonline.com/doi/abs/10.1080/03610918.2014.957840) metioned [Maximum Spacing Estimation](https://en.wikipedia.org/wiki/Maximum_spacing_estimation) has better performance than MLE.

## MLE for Pareto Type I

### Probability Density Function

$$
f(x; x_m, \alpha) = \frac{\alpha x_{m}^{\alpha}}{x_i^{\alpha + 1}} ~~~~
\begin{align}
& x \geq x_m \\
& x_m > 0, scale \\
& \alpha > 0, shape
\end{align}
$$

### Cumulative Density Function

$$
F(x; x_m, \alpha) = 1 - (\frac{x_m}{x})^{\alpha}
$$

### Likelihood Function

$$
L(\alpha, x_m; X) = \prod_{i=1}^{N} \frac{\alpha x_m^{\alpha}}{x_i^{\alpha + 1}}
$$

### Log-Likelihood Function

$$
\ell(\alpha, x_m; X) = Nln(\alpha) + N \alpha ln(x_m) - (\alpha + 1)\sum_{i=1}^{N} ln(x_i) 
$$

### First Derivatives

$$
\frac{\partial \ell}{\partial \alpha} = \frac{N}{\alpha} + Nln(x_m) - \sum_{i=1}^{N} ln(x_i) 
$$

$$
\frac{\partial \ell}{\partial x_m} = \frac{N\alpha}{x_m}
$$

### Duduced Parameters

It can be seen that log-likelihood function is monotonically increasing with $x_m$, that is, the greater the value of xm, the greater the value of the likelihood function. Hence, since $x \geq x_m$, we conclude that

$$
\hat{x_m} = \underset{i}{\min} x_i
$$

From $\frac{\partial \ell}{\partial \alpha} = 0$ we can know that:

$$
\hat{\alpha} = \frac{N}{\sum_{i = 1}^{N} ln(\frac{x_i}{\hat{x_m}})}
$$