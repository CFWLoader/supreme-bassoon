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

其中$\psi_n$为过去的Shocks的权重。

