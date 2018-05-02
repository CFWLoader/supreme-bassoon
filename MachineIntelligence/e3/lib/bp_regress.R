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