gen_states <- function(maze)
{
    states <- list()
    cnt <- 1
    for(row in 1:nrow(maze))
    {
        for(col in 1:ncol(maze))
        {
            if(maze[row, col] != "#")
            {
                states[[cnt]] <- c(row, col)
                cnt <- cnt + 1
            }
        }
    }
    states
}

move <- function(pos, act)
{
    if(act == "left")
    {
        c(pos[1] - 1, pos[2])
    }
    else if(act == "down")
    {
        c(pos[1], pos[2] - 1)
    }
    else if(act == "right")
    {
        c(pos[1] + 1, pos[2])
    }
    else if(act == "up")
    {
        c(pos[1], pos[2] + 1)
    }
}

eligibility <- function(pos, act, maze)
{
    moved <- move(pos, act)
    return(-1)
}

gen_tranmodel <- function(maze, actions)
{
    states <- gen_states(maze)
    numstate <- length(states)
    numact <- length(actions)
    transition <- array(0, dim = c(numstate, numstate, numact))
    for(i in 1:numstate)
    {
        for(j in 1:numstate)
        {
            for(k in numact)
            {
                transition[[i, j, k]] <- eligibility(states[[i]], actions[k], maze)
            }
        }
    }
    transition
}