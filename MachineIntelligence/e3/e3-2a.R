# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

training_set = read.csv("../datasets/RegressionData.txt", header = FALSE, sep = " ")

generate_weight_matrix <- function(row, col)
{
    return(matrix(runif(row * col, -0.5, 0.5), nrow = row, ncol  = col))
}

create_mlp_random <- function(num_input, num_output, num_mlp_hidden)
{
    num_hidden = length(num_mlp_hidden)

    weights <- list()

    weights[[1]] <- generate_weight_matrix(num_input, num_mlp_hidden[1])

    hidden_layer_index = 2

    while(hidden_layer_index <= num_hidden)
    {
        weights[[hidden_layer_index]] <- generate_weight_matrix(num_mlp_hidden[hidden_layer_index - 1], 
            num_mlp_hidden[hidden_layer_index])

        hidden_layer_index = hidden_layer_index + 1
    }

    weights[[num_hidden + 1]] <- generate_weight_matrix(num_mlp_hidden[num_hidden], num_output)

    return(weights)
}

# transfer_fun <- function(x)
# {
#     return(1/(1 + exp(-x)))
# }
transfer_fun <- tanh

forward_propagation <- function(input, weights, transfer_funs)
{
    layer_outputs = list()

    layer_input = input

    layer_index = 1

    for(weight_mat in weights)
    {
        # print(weight_mat)

        transfer_fun_mat = transfer_funs[[layer_index]]

        layer_output = numeric(length = ncol(weight_mat))

        layer_output[] = 0

        for(input_idx in c(1:nrow(weight_mat)))
        {
            for(output_idx in c(1:ncol(weight_mat)))
            {
                # print(paste(input_idx, output_idx, weight_mat[input_idx, output_idx]))
                
                layer_output[output_idx] = layer_output[output_idx] + 
                    weight_mat[input_idx, output_idx] * layer_input[input_idx]
            }
        }

        for(output_idx in c(1:length(layer_output)))
        {
            layer_output[output_idx] = transfer_fun_mat[[output_idx]](layer_output[output_idx])
        }

        layer_input = layer_output

        layer_outputs[[layer_index]] = layer_output

        layer_index = layer_index + 1
    }

    return(layer_outputs)
}

weights = create_mlp_random(1, 1, c(3))

transfer_funs = list()

transfer_funs[[2]] = c(function(x){return(x)})

transfer_funs[[1]] = c(transfer_fun, transfer_fun, transfer_fun)

layer_outputs = forward_propagation(training_set$V1[1], weights, transfer_funs)

print(layer_outputs)