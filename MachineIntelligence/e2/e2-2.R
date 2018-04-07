library(ggplot2)
library(reshape2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

mlp = function(x, w, a, b, activation = tanh)
{
    # Assume x, w, a, b all are vector, not matrix.
    result = vector(length = length(x))

    result[] = 0

    for(idx in c(1:length(x)))
    {
        for(f_idx in c(1:length(w)))
        {
            result[idx] = result[idx] + w[f_idx] * activation(a[f_idx] * (x[idx] - b[f_idx]))
        }
    }

    return(result)
}

# Input.
input_x = seq(-2, 2, 0.05)

dataset = NULL

tag_vec = vector(length = length(input_x))

clr_vec = vector(length = length(input_x))

err = NULL

min_err = NULL

best_set = NULL

for(mlp_count in c(1:50))
{
    w = rnorm(10)

    a = rnorm(10, 0, 2)

    b = runif(10, -2, 2)

    tag_vec[] = mlp_count

    clr_vec[] = 1

    y_out = mlp(input_x, w, a, b)

    err = 0.5 * sum((y_out - input_x)**2)

    tmp_dataset = data.frame(x = input_x, y = y_out, group_id = tag_vec, colour_id = clr_vec)

    dataset = rbind(dataset, tmp_dataset)

    if(min_err == NULL || err < min_err)
    {
        best_set = y_out

        min_err = err
    }
}

tag_vec = 51

clr_vec[] = 2

g_y = -input_x

dataset = rbind(dataset, data.frame(x = input_x, y = g_y, group_id =tag_vec, colour_id = clr_vec))

tag_vec = 52

clr_vec[] = 3

dataset = rbind(dataset, data.frame(x = input_x, y = best_set, group_id = tag_vec, colour_id = clr_vec))

ggplot(dataset, aes(x = x, y = y, group = as.factor(group_id), colour = as.factor(colour_id))) + geom_line() + scale_color_manual(values = c("grey", "blue", "green"))

ggsave("./e2-2a.png")

# question b.
dataset = NULL

tag_vec = vector(length = length(input_x))

clr_vec = vector(length = length(input_x))

for(mlp_count in c(1:50))
{
    w = rnorm(10)

    a = rnorm(10, 0, 0.5)

    b = runif(10, -2, 2)

    tag_vec[] = mlp_count

    clr_vec[] = 1

    y_out = mlp(input_x, w, a, b)

    dataset = rbind(dataset, data.frame(x = input_x, y = y_out, group_id = tag_vec, colour_id = clr_vec))
}

tag_vec = 51

clr_vec[] = 2

g_y = -input_x

dataset = rbind(dataset, data.frame(x = input_x, y = g_y, group_id = as.factor(tag_vec), colour_id = as.factor(clr_vec)))

ggplot(dataset, aes(x = x, y = y, group = group_id, colour = colour_id)) + geom_line() + scale_color_manual(values = c("grey", "blue"))

ggsave("./e2-2b.png")