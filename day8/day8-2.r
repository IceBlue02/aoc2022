
data = readLines("data.txt")



get_score_for_direction_lr <- function(d, x, y, inc) {
    height = strtoi(substr(d[y], x, x))
    if (x == 0 || y == 0 || x == nchar(y) || y == length(d)) {
        return(0)
    }
    score = 0

    while (1) {
        x = x + inc 

        if (x < 1 || x > length(d)) {
            break
        } else {
            score = score + 1
        }

        if (strtoi(substr(d[y], x, x)) >= height) {
            break
        }
    }

    return(score)
}

# Again, I shouldn't be lazy and these two should be one function...
get_score_for_direction_ud <- function(d, x, y, inc) {
    height = strtoi(substr(d[y], x, x))
    # Any tree on the edge returns a score of zero
    if (x == 0 || y == 0 || x == nchar(y) || y == length(d)) {
        return(0)
    }
    score = 0

    while (1) {
        y = y + inc 

        if (y < 1 || y > length(d)) {
            break
        } else {
            score = score + 1
        }

        if (strtoi(substr(d[y], x, x)) >= height) {
            break
        }
    }

    return(score)
}

get_score <- function(d, x, y) {
    return (
        get_score_for_direction_ud(d, x, y, 1) *
        get_score_for_direction_ud(d, x, y, -1) *
        get_score_for_direction_lr(d, x, y, 1) *
        get_score_for_direction_lr(d, x, y, -1)
    )
}

best_score <- 0
for (y in 1:length(data)) {
    for (x in 1:nchar(data[y])) {
        score <- get_score(data, x, y)
        if (score > best_score) {
            best_score <- score
        }
    }
}
print(best_score)


