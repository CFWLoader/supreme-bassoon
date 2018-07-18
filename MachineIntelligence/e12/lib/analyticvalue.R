generate_rewards <- function(actions, states)
{
    num_acts <- length(actions)
    num_states <- length(states)

    rewards <- matrix(0, nrow = num_states, ncol = num_acts)
    
    for(sidx in 1:num_states)
    {
        for(aidx in 1:num_acts)
        {
            rewards[sidx, aidx] <- ifelse(states[sidx] == "X", 1, 0)
        }
    }

    rewards
}

generate_uniform_policy <- function(actions, states)
{
    num_acts <- length(actions)
    num_states <- length(states)

    rewards <- matrix(0, nrow = num_states, ncol = num_acts)
    
    for(sidx in 1:num_states)
    {
        for(aidx in 1:num_acts)
        {
            rewards[sidx, aidx] <- 1/num_acts
        }
    }

    rewards
}

analyticvalue <- function(maze)
{

}