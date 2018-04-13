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

generate_and_plot = function(input_x, num_hidden, num_mlps, a_stddev, file_path)
{
    dataset = NULL

    tag_vec = vector(length = length(input_x))

    clr_vec = vector(length = length(input_x))

    min_err = NULL

    err = NULL

    y_set = NULL

    for(mlp_count in c(1:50))
    {
        w = rnorm(num_hidden)

        a = rnorm(num_hidden, 0, a_stddev)

        b = runif(num_hidden, -2, 2)

        tag_vec[] = mlp_count

        clr_vec[] = 1

        y_out = mlp(input_x, w, a, b)

        # err = 0.5 * sum((y_out + input_x)**2)
        err = 0.5 * sum((y_out - input_x)**2)

        if(is.null(min_err) || err < min_err)
        {
            min_err = err

            y_set = y_out
        }

        dataset = rbind(dataset, data.frame(x = input_x, y = y_out, group_id = tag_vec, color_id = clr_vec))
    }

    ngy = - input_x

    tag_vec[] = num_mlps + 1

    clr_vec[] = 2

    dataset = rbind(dataset, data.frame(x = input_x, y = ngy, group_id = tag_vec, color_id = clr_vec))

    tag_vec[] = num_mlps + 2

    clr_vec[] = 3

    dataset = rbind(dataset, data.frame(x = input_x, y = y_set, group_id = tag_vec, color_id = clr_vec))

    ggplot(dataset, aes(x = x, y = y, group = group_id, color = as.factor(color_id))) + geom_line() + scale_color_manual(values = c("grey", "blue", "darkgreen"))

    ggsave(file_path)
}

# question a.
generate_and_plot(input_x = input_x, num_hidden = 10, num_mlps = 50,  a_stddev = 2, "./e2-2a.png")

# question b.
generate_and_plot(input_x = input_x, num_hidden = 10, num_mlps = 50,  a_stddev = 0.5, "./e2-2b.png")