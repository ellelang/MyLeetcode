theMatrix = [
                [ 4, 8, 7, 3],
                [ 2, 5, 9, 3],
                [ 6, 3, 2, 5],
                [ 4, 4, 1, 6]
]

def longest_path(matrix):
    def inner_longest_path(x, y):
        best, best_path = 0, []
        # for all possible neighbor cells...
        for dx, dy in ((+1, 0), (-1, 0), (0, +1), (0, -1)):
            # if cell is valid and strictly smaller...
            if (0 <= x + dx < len(matrix) and 0 <= y + dy < len(matrix[x]) 
                    and (matrix[x+dx][y+dy] - matrix[x][y]) == 1):
                n, path = inner_longest_path(x+dx, y+dy)  ### RECURSION
                # check if the path starting at that cell is better
                if n > best:
                    best, best_path = n, path
        return best + 1, [matrix[x][y]] + best_path

    return max(inner_longest_path(x, y) for x, row in enumerate(matrix) 
                                         for y, _ in enumerate(row))

print( longest_path(theMatrix) )


mat = [[1, 2, 9],  
    [5, 3, 8], 
    [4, 6, 7]]  


print( longest_path(mat) )

theMatrix = [
                [ 4, 8, 7, 3],
                [ 2, 5, 9, 3],
                [ 6, 3, 2, 5],
                [ 4, 4, 1, 6]
]

def longest_path(matrix):
    def inner_longest_path(x, y):
        best, best_path = 0, []
        # for all possible neighbor cells...
        for dx, dy in ((+1, 0), (-1, 0), (0, +1), (0, -1)):
            # if cell is valid and strictly smaller...
            if (0 <= x + dx < len(matrix) and 0 <= y + dy < len(matrix[x]) 
                    and matrix[x+dx][y+dy] < matrix[x][y]):
                n, path = inner_longest_path(x+dx, y+dy)  ### RECURSION
                # check if the path starting at that cell is better
                if n > best:
                    best, best_path = n, path
        return best + 1, [matrix[x][y]] + best_path

    return max(inner_longest_path(x, y) for x, row in enumerate(matrix) 
                                         for y, _ in enumerate(row))

print( longest_path(theMatrix) )
