# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

training_set = read.csv("../datasets/RegressionData.txt", header = FALSE, sep = " ")

ones_vec = rep(1, times = nrow(training_set));

# ones_vec[] = 1

x_mat = matrix(c(training_set$V1, ones_vec), ncol = 2)

y_t = as.numeric(training_set$V2)

generate_weight_matrix <- function(row, col)
{
    return(matrix(runif(row * col, -0.5, 0.5), nrow = row, ncol  = col))
}

create_mlp_random <- function(num_input, num_output, num_mlp_hidden)
{
    num_hidden = length(num_mlp_hidden)

    weights <- list()

    weights[[1]] <- generate_weight_matrix(num_input + 1, num_mlp_hidden[1])

    hidden_layer_index = 2

    while(hidden_layer_index <= num_hidden)
    {
        weights[[hidden_layer_index]] <- generate_weight_matrix(num_mlp_hidden[hidden_layer_index - 1] + 1, 
            num_mlp_hidden[hidden_layer_index])

        hidden_layer_index = hidden_layer_index + 1
    }

    weights[[num_hidden + 1]] <- generate_weight_matrix(num_mlp_hidden[num_hidden] + 1, num_output)

    return(weights)
}

forward_propagation <- function(input, weights, transfer_funs)
{
    layer_outputs = list()

    layer_input = input

    layer_index = 1

    ones_vec = rep(1, times = nrow(layer_input))

    for(weight_mat in weights)
    {
        transfer_fun_mat = transfer_funs[[layer_index]]

        layer_output = layer_input %*% weight_mat

        for(output_idx in c(1:ncol(layer_output)))
        {
            layer_output[,output_idx] = transfer_fun_mat[[output_idx]](layer_output[,output_idx])
        }

        layer_input = cbind(layer_output, ones_vec)

        layer_outputs[[layer_index]] = layer_output

        layer_index = layer_index + 1
    }

    return(layer_outputs)
}

back_propagation <- function(input, layer_outputs, errors, weights)
{
    delta_weights = list()
}

transfer_fun <- tanh

weights = create_mlp_random(1, 1, c(3))

transfer_funs = list()

# transfer_funs[[3]] = c(function(x){return(x)})

# transfer_funs[[2]] = c(transfer_fun, transfer_fun, transfer_fun, transfer_fun)

transfer_funs[[2]] = c(function(x){return(x)})

transfer_funs[[1]] = c(transfer_fun, transfer_fun, transfer_fun)

layer_outputs = forward_propagation(x_mat, weights, transfer_funs)

print(sum((layer_outputs[[2]] - y_t)**2)/2)