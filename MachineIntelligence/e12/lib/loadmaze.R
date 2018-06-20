loadmaze <- function(file_path)
{
    raw_input <- file(file_path, open = "r")

    lines <- readLines(raw_input)

    mazes <- list()
    cnt <- 1

    maze <- NULL

    for(line in lines)
    {
        if(line == "" && !is.null(maze))
        {
            mazes[[cnt]] <- maze
            cnt <- cnt + 1
            maze <- NULL
        }
        else if(line != "")
        {
            maze <- rbind(maze, matrix(strsplit(line, "")[[1]], nrow = 1))
        }
    }

    close(raw_input)

    mazes
}