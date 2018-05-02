# Autocorrelation Function and Spectrum of Stationary Processes

### Stochastic Process

[Wiki](https://en.wikipedia.org/wiki/Stochastic_process)

### Autocorrelation Function

[Wiki](https://en.wikipedia.org/wiki/Autocorrelation)

### Spectral Density Function

[Wiki](https://en.wikipedia.org/wiki/Spectral_density)

### Deterministic and Statistical Time Series，确定性与统计时间序列

若序列中的值可以通过一个固定的数学公式描述，例如：

$$
z_t = cos(2\pi ft)
$$

则该时间序列是确定的（deterministic）。若序列中的值只能通过统计模型描述，则该序列是非确定的（nondeterministic）或者称为统计时间序列（Statistical Time Series）。

## <font color="orange">In analyzing a time series, we regard Time Series as a realization of a stochastic process.</font>

## 平稳随机过程

根据`平稳随机过程`的定义，`过程`的`均值`以及`方差`是`固定的`，注意以下的推理仅在此上下文内有效。

### Autocovariance and Autocorrelation Coefficients

个人理解，自协方差以及自相关系数中的自是因为所有的变量都是针对观测变量$z_t$，故加上了“自”；而每一个时刻的$z_t$被视作不同的统计量，例如$t+s$时刻与$t$时刻的协方差：

$$
cov(z_{t+s},z_t) = E[(z_{t+s} - \mu_{t+s})(z_t - \mu_{t})]
$$

根据时刻的多少构成了自协方差矩阵：

$$
\left[
\begin{matrix}
var(z_1) & cov(z_1, z_2) & ... & cov(z_1, z_t) \\
cov(z_2, z_1) & var(z_2) & ... & cov(z_2, z_t) \\
... & ... & ... & ... \\
cov(z_t, z_1) & cov(z_t, z_1) & ... & var(z_t)
\end{matrix}
\right]
$$

自相关系数同理。要注意的是在`平稳随机过程`的语境下，$\mu$以及$\sigma$是固定的，于是自协方差可以表示为：

$$
\gamma_s = cov(z_{t+s}, z_t) =  E[(z_{t+s} - \mu)(z_t - \mu)]
$$

以及自相关系数：

$$
\rho_s = \frac{cov(z_{t+s}, z_t)}{\sigma_z^2} = \frac{\gamma_s}{\gamma_0}
$$

### Autocovariance Matrix，自协方差矩阵

在平稳随机过程中，以及上述语境的定义，协方差矩阵可以表示为：

$$
\mathbf{\Gamma}_n = 
\left[
    \begin{matrix}
    \gamma_0 & \gamma_1 & ... & \gamma_{n-1} \\
    \gamma_1 & \gamma_0 & ... & \gamma_{n-2} \\
    ... & ... & ... & ... \\
    \gamma_{n-1} & \gamma_{n-2} & ... & \gamma_0
    \end{matrix}
\right] = \sigma_z^2
\left[
    \begin{matrix}
    1 & \rho_1 & ... & \rho_{n-1} \\
    \rho_1 & 1 & ... & \rho_{n-2} \\
    ... & ... & ... & ... \\
    \rho{n-1} & \rho{n-2} & ... & 1
    \end{matrix}
\right] = \sigma_z^2 \mathbf{P}_n
$$