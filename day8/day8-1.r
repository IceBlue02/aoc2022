
data = readLines("data.txt")



check_lr <- function(d, inc) {
    visible <- list()
    for (y in 1:length(d)) {
        maxtree = -1
        if (inc == 1) {
            x = 1
        } else {
            x = nchar(d[y])
        }

        #while x
        while (maxtree != 9 && x <= nchar(d[y]) && x >= 1) {
            if (strtoi(substr(d[y], x, x)) > maxtree) {
                visible <- append(visible, x * 100 + y)
                maxtree = strtoi(substr(d[y], x, x))
            }
            x = x + inc 
        }
        
    
    }
    return(visible)
}

# Really, this should be combined with the above, but it's just easier to 
check_ud <- function(d, inc) {
    visible <- list()
    for (x in 1:length(d)) {
        maxtree = -1
        if (inc == 1) {
            y = 1
        } else {
            y = length(d)
        }

        #while x
        while (maxtree != 9 && y <= length(d) && y >= 1) {
            if (strtoi(substr(d[y], x, x)) > maxtree) {
                visible <- append(visible,  x * 100 + y)
                maxtree = strtoi(substr(d[y], x, x))
            }
            y = y + inc 
        }
        
    
    }
    return(visible)
}

v <- list()
v <- append(v, check_lr(data, 1))
v <- append(v, check_lr(data, -1))
v <- append(v, check_ud(data, 1))
v <- append(v, check_ud(data, -1))

print(length(v))
unv <- unlist(v)
print(length(unv[!duplicated(unv)]))


