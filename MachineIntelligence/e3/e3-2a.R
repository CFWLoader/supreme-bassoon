# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

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

# error_fun <- function(y_out, y_tag)
# {
#     return(y_tag * log(y_out) + (1 - y_tag) * log(1 - y_out))
# }

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

# Gradients for 1 hidden layer's bp.
# It's hard to be generalized because of derivatives.
# After deducing derivatives by my self, I think I might code a more generic version bp.
back_propagation_gradients_f1h <- function(input, sample_output, layer_outputs, weights)
{
    sample_size = nrow(input)

    delta_weights = list()

    outputs_input_weights = weights[[2]]

    hidden_outputs = layer_outputs[[1]]

    y_hat = layer_outputs[[2]]

    total_errors = y_hat - sample_output

    # Calculate gradients for hidden layer.
    hidden_gradients = t(hidden_outputs) %*% total_errors
    # hidden_gradients = t(total_errors) %*% hidden_outputs
    # hidden_gradients = t(hidden_gradients)
    hidden_gradients = rbind(hidden_gradients, sum(total_errors)) * (1 / sample_size)

    # hidden_gradients = matrix(nrow = ncol(hidden_outputs) + 1)
    # for(idx in c(1:ncol(hidden_outputs)))
    # {
    #     hidden_gradients[idx] = hidden_outputs[,idx] %*% total_errors
    # }
    # hidden_gradients[ncol(hidden_outputs) + 1] = sum(total_errors)

    # print(hidden_gradients)
    input_gradients = matrix(nrow = nrow(weights[[1]]), ncol = ncol(weights[[1]]))

    for(j in c(1:ncol(hidden_outputs)))
    {
        # tmp_grad1 = matrix(rep(0, nrow(hidden_outputs)), ncol = 1)

        # for(idx in c(1:nrow(tmp_grad1)))
        # {
        #     tmp_grad1[idx, 1] = outputs_input_weights[j] * total_errors[idx] * hidden_outputs[idx,j] * (1 - hidden_outputs[idx,j])
        # }

        # print(tmp_grad1)

        tmp_grad = outputs_input_weights[j] * total_errors * hidden_outputs[,j] * (1 - hidden_outputs[,j])

        # print(tmp_grad == tmp_grad1)

        # print(tmp_grad)

        input_gradients[1, j] = (t(tmp_grad) %*% input[, 1]) / sample_size
        input_gradients[2, j] = sum(tmp_grad) / sample_size
        # print(t(input) %*% tmp_grad)

        # print(out_deri)
    }

    # print(input_gradients)
    delta_weights[[1]] = input_gradients
    delta_weights[[2]] = hidden_gradients

    return(delta_weights)
}

training_set = read.csv("../datasets/RegressionData.txt", header = FALSE, sep = " ")

ones_vec = rep(1, times = nrow(training_set));

# ones_vec[] = 1

x_mat = matrix(c(training_set$V1, ones_vec), ncol = 2)

y_t = as.numeric(training_set$V2)

transfer_fun <- tanh

weights = create_mlp_random(1, 1, c(3))

# Mock weights.
# weights = list()
# weights[[1]] = matrix(c(-0.3656297,-0.3661961,-0.17760791, 0.3747940,-0.4960355,-0.04454495), nrow = 2, byrow = TRUE)
# weights[[2]] = matrix(c(-0.4412941376,-0.3838144105,0.0008371437, -0.4455131863), ncol = 1)

# print(weights)

transfer_funs = list()

# transfer_funs[[3]] = c(function(x){return(x)})

# transfer_funs[[2]] = c(transfer_fun, transfer_fun, transfer_fun, transfer_fun)

transfer_funs[[2]] = c(function(x){return(x)})

transfer_funs[[1]] = c(transfer_fun, transfer_fun, transfer_fun)

t = 1

learning_rate = 0.5

err = c()

while(t <= 3000)
{
    layer_outputs = forward_propagation(x_mat, weights, transfer_funs)

    gradients = back_propagation_gradients_f1h(x_mat, y_t, layer_outputs, weights)

    err = c(err, 0.5 * sum((y_t - layer_outputs[[2]])**2))

    weights[[1]] = weights[[1]] - (learning_rate * gradients[[1]])
    weights[[2]] = weights[[2]] - (learning_rate * gradients[[2]])

    # print(gradients)
    t = t + 1
}

print(err[1])

print(err[2])

print(err[3000])

# print(sum((layer_outputs[[2]] - y_t)**2)/2)