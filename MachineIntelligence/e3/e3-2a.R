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

forward_propagation <- function(input, weights)
{
    layer_outputs = list()

    for(weight_mat in weights)
    {
        # print(weight_mat)
        
    }
}

weights = create_mlp_random(1, 1, c(3))

forward_propagation(training_set$V1, weights)

# print(weights)