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
run_test_and_plot = function (input_x, num_n_hid, num_mlps, a_stddev, file_path)
{
    dataset = NULL

    err = NULL

    min_err = NULL

    best_set = NULL

    tag_vec = vector(length = length(input_x))

    clr_vec = vector(length = length(input_x))

    for(mlp_count in c(1:num_mlps))
    {
        w = rnorm(num_n_hid)

        a = rnorm(num_n_hid, 0, a_stddev)

        b = runif(num_n_hid, -2, 2)

        tag_vec[] = mlp_count

        clr_vec[] = 1

        y_out = mlp(input_x, w, a, b)

        err = 0.5 * sum((y_out - input_x)**2)

        dataset = rbind(dataset, data.frame(xa = input_x, ya = y_out, group_id = tag_vec, colour_id = clr_vec))

        if(is.null(min_err) || err < min_err)
        {
            best_set = y_out

            min_err = err
        }
    }

    tag_vec = num_mlps + 1

    clr_vec[] = 2

    g_y = -input_x

    dataset = rbind(dataset, data.frame(xa = input_x, ya = g_y, group_id = tag_vec, colour_id = clr_vec))

    tag_vec = num_mlps + 2

    clr_vec[] = 3

    dataset = rbind(dataset, data.frame(xa = input_x, ya = best_set, group_id = tag_vec, colour_id = clr_vec))

    ggplot(dataset, aes(x = xa, y = ya, group = as.factor(group_id), colour = as.factor(colour_id))) + geom_line() + scale_color_manual(values = c("grey", "darkblue", "darkgreen"))

    # ggplot(dataset, aes(x = xa, y = ya, group = as.factor(group_id))) + geom_line()

    ggsave(file_path)
}

# question a and c.
input_x = seq(-2, 2, 0.05)

run_test_and_plot(input_x, num_n_hid = 10, num_mlps = 50, a_stddev = 2, file_path = "./e2-2a.png")

# question b and c.
run_test_and_plot(input_x, num_n_hid = 10, num_mlps = 50, a_stddev = 0.5, file_path = "./e2-2b.png")