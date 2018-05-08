## 注意点

对于任意`指数平滑`的公式，其预测值与各参数间的关系，如`AN`模型：

$$
\hat{X}_t(m) = S_t + mT_t
$$

该公式有一定的迷惑性，建议使用下述公式理解：

$$
\hat{X}_{t+m} = S_t + mT_t ~~~~~~~~ m \in Z^+
$$

换言之，在`t`周期所得的所有参数，仅能预测$t+1, t+2, ..., t+n$周期的值，不能使$m=0$获得当前周期的值。

对于在代码中使用
``` R
sv <- alpha * x[t - 1] + (1 - alpha) * (sv.vec[prd - 1] + trend.vec[prd - 1])    # 求t时刻一阶平滑值（AN模型）
...
trend <- gamm * (sv.vec[prd] - sv.vec[prd - 1]) + (1 - gamm) * trend.vec[prd - 1]   # t时刻的趋势
...
x.prd.vec <- c(x.prd.vec, sv + trend)       # t+1时刻的预测值
```
其观测值的`（t-1）下标`与`平滑值`、`趋势值`等恰好符合，而不是使用`x[t]`的原因。考虑求`t=1`周期时的向前`1个周期`的预测值：

$$
\begin{align}
& \hat{X}_1(1) = \hat{X}_{2} = S_1 + T_1 \\
& S_1 = \alpha X_1 + (1 - \alpha)(S_{0} + T_{0}) \\
& T_1 = \gamma(S_1 - S_{0}) + (1-\gamma)T_{0}
\end{align}
$$

因为`R`向量的下标是从`1`开始的，但是填入的是`0`周期的初始值，所以`平滑值向量`以及`趋势值向量`的下标整体后挪一位，恰好与`观测值`存储时的`下标`一致了。

下标关系（AN模型）演示：

$$
\begin{matrix}
t & 0 & 1 & 2 & ... & T \\
平滑值 & s_0 & s_1 & s_2 & ... & s_T \\
趋势值 & trn_0 & trn_1 & trn_2 & ... & trn_T \\
观测值 & NULL & X_1 & X_2 & ... & X_T \\
预测值（m=1） &  \hat{X}_{1} = s_0 + trn_0 & \hat{X}_{2} = s_1 + trn_1 & \hat{X}_{3} = s_2 + trn_2 & ... & \hat{X}_{T+1} = s_T + trn_T
\end{matrix}
$$

存储向量时：

$$
\begin{matrix}
R下标 & 1 & 2 & 3 & ... & T \\
平滑值 & s_0 & s_1 & s_2 & ... & s_{T-1} \\
趋势值 & trn_0 & trn_1 & trn_2 & ... & trn_{T-1} \\
观测值 & X_1 & X_2 & X_3 & ... & X_T \\
预测值（m=1） &  \hat{X}_{1} = s_0 + trn_0 & \hat{X}_{2} = s_1 + trn_1 & \hat{X}_{3} = s_2 + trn_2 & ... & \hat{X}_{T} = s_{T-1} + trn_{T-1}
\end{matrix}
$$

## Addictive Trend No Seasonality

$$
\begin{align}
& S_t = \alpha X_t + (1 - \alpha)(S_{t-1} + T_{t-1}) \\
& T_t = \gamma(S_t - S_{t-1}) + (1-\gamma)T_{t-1} \\
& \hat{X}_t(m) = S_t + mT_t
\end{align}
$$

We might derive the backward form:

$$
\begin{align}
& T_{t-1} = T_t - \gamma S_t + \gamma \frac{S_t - \alpha X_t}{1 - \alpha} \\
& S_{t-1} = (1 - \gamma)\frac{S_t - \alpha X_t}{1 - \alpha} - T_t + \gamma S_t
\end{align}
$$