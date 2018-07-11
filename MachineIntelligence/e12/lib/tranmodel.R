gen_states <- function(maze)
{
    states <- list()
    gridmap <- list()
    cnt <- 1
    for(row in 1:nrow(maze))
    {
        for(col in 1:ncol(maze))
        {
            if(maze[row, col] != "#")
            {
                states[[cnt]] <- maze[row, col]
                gridmap[[cnt]] <- c(row, col)
                cnt <- cnt + 1
            }
        }
    }
    list(states = states, gridmap = gridmap)
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

# eligibility <- function(pos, act, maze)
# {
#     moved <- move(pos, act)
#     return(-1)
# }

gen_tranmodel <- function(maze, actions)
{
    datapack <- gen_states(maze)
    states <- datapack$states
    gridmap <- datapack$gridmap
    numstate <- length(states)
    numact <- length(actions)
    transition <- array(0, dim = c(numstate, numstate, numact))
    for(i in 1:numstate)
    {
        for(j in 1:numstate)
        {
            for(k in numact)
            {
                if(i == j)
                {
                    t = move(gridmap[[i]], actions[k])
                    transition[i, j, k] = ifelse(maze[t[0]][t[1]] == '#', 1, 0)  # check if state target is a wall (maze must be enclosed by walls)
                }
                else
                {
                    transition[i, j, k] = ifelse(all(move(gridmap[[i]], actions[k]) == gridmap[[j]]), 1, 0)
                    # P[i,j,k] = (move(mapping[i], A[k]) == mapping[j]) + 0.0
                }
            }
        }
    }
    datapack$transition.model <- transition
    datapack
}