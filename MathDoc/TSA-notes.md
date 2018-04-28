# Time Series Analysis

## 基本概念及符号

### Transfer function 转移函数

[Wiki](https://en.wikipedia.org/wiki/Transfer_function)

### Impulse Response (Function) 脉冲响应

[Wiki](https://en.wikipedia.org/wiki/Impulse_response)

### Feed-Foward Control 前馈控制法，预先控制

<a href="https://en.wikipedia.org/wiki/Feed_forward_(control)">Wiki</a>

### Feedback Control 反馈控制法

We may be able to use the deviation from target or “error signal” of the output characteristic itself to calculate appropriate compensatory changes in the control variable.

### Statistical Process Control(SPC) 统计过程控制

A method of [Quality Control](https://en.wikipedia.org/wiki/Quality_control).

[Wiki](https://en.wikipedia.org/wiki/Statistical_process_control)

### Engineering/Automatic Process Control(EPC/APC) 过程控制

[Wiki](https://en.wikipedia.org/wiki/Process_control)

This type of control is necessary when there are inherent disturbances or noise in the system inputs that are impossible or impractical to remove. When we can measure fluctuations in an input variable that can be observed but not changed, it may be possible to make appropriate compensatory changes in some other control variable. Referred as Feed-Foward Control.

### Nomogram 诺模图，列线图

[Wiki](https://en.wikipedia.org/wiki/Nomogram)

### Deterministic Models 确定性模型

In particular, it is sometimes possible to derive a model based on physical laws, which enables us to calculate the value of some
time-dependent quantity nearly exactly at any instant of time. Thus, we might calculatethe trajectory of a missile launched in a known direction with known velocity. If exact calculation were possible, such a model would be entirely deterministic.

### Stochastic Models 随机模型

In many problems we have to consider a time-dependent phenomenon, such as monthly sales of newsprint, in which there are many unknown factors and for which it is not possible to write a deterministic model that allows exact calculation of the future behavior of the phenomenon. Nevertheless, it may be possible to derive a model that can be used to calculate the probability of a future value lying between two specified limits.

### Statistical Equilibrium 统计均衡

[Wiki](https://en.wikipedia.org/wiki/Statistical_mechanics)

### Stationary Models 平稳模型

Stationary models assume that the process remains in statistical equilibrium with probabilistic properties that do not change over time, in particular varying about a fixed constant mean level and with constant variance.

### Nonstationary Models 非平稳模型

[Wiki](https://en.wikipedia.org/wiki/Stationary_process)

### AutoRegressive Integrated Moving Average 自回归积分滑动平均模型，ARIMA模型

非平稳模型的一种。

[Wiki](https://en.wikipedia.org/wiki/Autoregressive_integrated_moving_average)

### 操作符定义

#### Backward Shift Operator 后移算子

$$
\begin{align}
Bz_t = z_{t-1} \\
B^m z_t = z_{t-m}
\end{align}
$$

#### Forward Shift Operator 前移算子

$$
\begin{align}
F=B^{-1} \\
Fz_t = z_{t+1} \\
F^m z_t = z_{t+m}
\end{align}
$$

#### Backward Difference Operator 后向差分算子

$$
\nabla z = z_t - z_{t-1} = (1-B)z_t
$$

### Linear Filter Model 线性过滤模型

假设每个时刻$t$的$a_t$(independent "shocks")通常设定服从正态分布$a_t \sim \mathcal{N}(0, \sigma_a^2)$，则称随机变量序列$a_t, a_{t-1}, a_{t-2}, ...$为白噪声过程（White Noise Process）。

假设白噪声过程$a_t$可以通过线型过滤器（Linear Filter）转化为过程$z_t$。

$$
\begin{align}
z_t & = \mu + a_t + \psi_1 a_{t-1} + \psi_2 a_{t-2} + ...\\
& = \mu + \psi(B) a_t
\end{align}
$$

其中$\psi_n$为过去的Shocks的权重，$\mu$为`Level`。

$$
\psi(B) = 1 + \psi_1 B + \psi_2 B^2 + ...
$$

称为`转移函数`（Transfer Function）或`过滤器`（Filter）。

如果有：

$$
\sum_{i=1}^{\infty} |\psi_i| < \infty
$$

则称过滤器是`稳定的`（stable），以及过程$z_t$是`平稳的`，$\mu$为随过程而变化的均值。若$\mu$除了指示`Level`之外无特殊意义，则过程$z_t$是`不平稳的`。

### Autoregressive Model 自回归模型

一种随机模型。过程$z_t$被表示过去的过程以及随机冲击（shock）$a_t$的线性聚合。

用等时间间隔的$z_t, z_{t-1}, z_{t-2}, ...$表示过程的值，$\tilde{z}_t = z_t - \mu$表示$z_t$与$\mu$的偏差（deviation）。则

$$
\tilde{z}_t = \phi_1 \tilde{z}_{t-1} + \phi_2 \tilde{z}_{t - 2} + ... + \phi_p \tilde{z}_{t-p} + a_t
$$

称为$p$阶自回归过程（Autoregressive(AR) process of p order）。

因为方程像一般的线性回归方程而得其名：

$$
\tilde{z}_t = \phi_1 \tilde{x}_{1} + \phi_2 \tilde{x}_{1} + ... + \phi_p \tilde{x}_{p} + a_t
$$

定义自回归算子（Autoregressive Operator）：

$$
\phi(B) = 1 - \phi_1 B - \phi_2 B^2 - ... - \phi_p B^p
$$

则自回归模型可以简单写成：

$$
\phi(B)\tilde{z}_t = a_t
$$

该模型中存在$p+2$个未知参数$\mu,\phi_1,\phi_2,...,\phi_p,\sigma_a^2$，其中$\sigma_a^2$为白噪声过程$a_t$的方差。

自回归模型是现行过滤模型的一个特殊案例。

考察：

$$
\begin{align}
\phi(B)\tilde{z}_t & = a_t \\
\phi(B)\tilde{z}_t & = \phi^{-1}(B)a_t = \psi(B)a_t
\end{align}
$$

则可以看出表达式的一致性。

AR模型可以是平稳的，也可以是非平稳的。如果是平稳的，则根据$\sum_{i=1}^{\infty} |\psi_i| < \infty$条件，则可以推导出$\psi(B) = \phi^{-1}(B)$是一个收敛数列。对于`滞后算子多项式`$\phi(B) = 1 - \phi_1 B - \phi_2 B^2 - ... - \phi_p B^p$，则有该多项式$\phi(B)=0$的根大于0，否则无法保证$\psi(B) = \phi^{-1}(B)$收敛，进而无法保证$\sum_{i=1}^{\infty} |\psi_i| < \infty$条件。

### Moving Average Model 滑动平均模型

符号意义同上。

$$
\tilde{z}_t = a_t - \theta_1 a_{t - 1} - \theta_2 a_{t - 2} - ... - \theta_q a_{t-q}
$$

定义滑动平均算子（Moving Average Operator）:

$$
\theta(B) = 1 - \theta_1 B^1 - \theta_2 B^2 - ... - \theta_q B^q
$$

$$
\tilde{z}_t = \theta(B)a_t
$$

该模型中存在$q+2$个未知参数$\mu,\phi_1,\phi_2,...,\phi_q,\sigma_a^2$，其中$\sigma_a^2$为白噪声过程$a_t$的方差。

### (Mixed) Autoregressive-Moving Average （混合）自回归滑动平均，ARMA模型

$$
\tilde{z}_t = \phi_1 \tilde{z}_{t-1} + ... + \phi_p \tilde{z}_{t-p} + a_t - \theta_1 a_{t-1} - ... - \theta_q a_{t-q}
$$

或者：

$$
\phi(B) \tilde{z}_t = \theta(B) a_t
$$

### Nonstationary Models 非平稳模型

$$
\phi(B) = \Phi(B)(1-B)^d
$$

其中求$\phi(B)=0$时有$d$个$B=1$根并且其余根都大于1，$\Phi(B)$为平稳自回归算子。则一个模型可以被表示为齐次非平稳行为：

$$
\phi(B)z_t = \Phi(B)(1-B)^d z_t = \theta(B) a_t
$$

进而表示为：

$$
\Phi(B)w_t = \theta(B) a_t
$$

其中：

$$
w_t = (1-B)^d z_t = \nabla^d z_t
$$

上述算是表达的即是`ARIMA模型`（Autoregressive Integrated Moving Average Model，自回归积分滑动平均模型），其阶(order)由$(p,d,q)$共同组成，过程的具体定义：

$$
w_t = \phi_1 w_{t-1} + ... + \phi_p w_{t-p} + a_t - \theta_1 a_{t-1} - ... - \theta_q a_{t-q}
$$

逆运算：

$$
z_t = (\nabla^{-1})^d w_t = S^d w_t
$$

其中：

$$
S = \nabla^{-1} = 1 + B + B^2 + ...
$$

$$
S^d w_t = \sum_{j=0}^{\infty} w_{t-j}= w_t + w_{t-1} + ... 
$$

该求和过程像“积分”而得出名字中的“Integrated”。

### Transfer Function Model 转移函数模型

$$
(1+\xi_1 \nabla + ... + \xi_r \nabla^r)Y_t = (\eta_0 + \eta_1 \nabla + ... \eta_s \nabla^s)X_{t-b} \\
$$

$$
\nabla = 1 - B
$$

通过$B = 1 - \nabla$可以将公示转化为：

$$
\begin{align}
(1-\delta_1 B - ... - \delta_r B^r)Y_t & = (\omega_0 - \omega_1 B - ... \omega_s B^s)X_{t-b} \\
& = (\omega_0 - \omega_1 B^{b+1} - ... \omega_s B^{b+s})X_{t}
\end{align}
$$

或者：

$$
\delta(B)Y_t = \omega(B)B^b X_{t} = \Omega X_{t} 
$$

过程$Y_t$可以通过`转移函数`与$X_t$联系起来：

$$
\begin{align}
Y_t & = v_0 X_t + v_{1} X_{t - 1} + ... \\
& = v(B)X_t
\end{align}
$$

转移函数：

$$
v(B) = v_0 + v_1 B + v_2 B^2 + ...
$$

$$
v(B) = \frac{\Omega{B}}{\omega{B}} = \omega^{-1}(B)\Omega{B}
$$

当$|B|\leq 1$，或等价条件$\sum_{j=0}^{\infty} |v_j| < \infty$成立，则该模型是平稳的。

其中序列$v_0, v_1, v_2, ...$称为`脉冲响应函数`。

### Models with superimposed Noise 叠加噪声模型

$$
Y_t = v(B)X_t + N_t
$$

其中$X_t$，$N_t$为独立的过程。噪声$N_t$可以被描述为非平稳的或平稳的随机模型。

$$
N_t = \psi(B)a_t = \phi^{-1}(B)\theta(B)a_t
$$

这样公式可以进一步描述为：

$$
\begin{align}
Y_t & = v(B)X_t + \psi(B)a_t \\
& = \delta^{-1}(B)\Omega(B)X_t + \phi^{-1}(B)\theta(B)a_t
\end{align}
$$