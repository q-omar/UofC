import sys

ROWS = 10
COLUMNS = 10
HORIZONTAL_NUMBERS = "0123456789"
START_ROW = 1
START_COLUMN = 1
EMPTY = ' '
WALL = 'W'
EXIT = 'X'
GOOD_PATH = '+'
TRIED = '-'


def initialize (maze):
    r = 0
    c = 0
    #Initialize every square to a space so we know that each location has
    #been set to some default value.
    for r in range (0, ROWS, 1):
        maze.append([])
        for c in range (0, COLUMNS, 1):
   	     maze[r].append(" ")

    maze [0] = ['W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W']
    maze [1] = ['W', 'S', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'W']
    maze [2] = ['W', ' ', 'W', 'W', 'W', 'W', ' ', 'W', 'W', 'W']
    maze [3] = ['W', ' ', 'W', 'W', 'W', ' ', ' ', ' ', 'W', 'W']
    maze [4] = ['W', ' ', 'W', 'W', 'W', 'W', ' ', 'W', 'W', 'W']
    maze [5] = ['W', ' ', 'W', 'W', 'W', 'W', ' ', ' ', ' ', 'W']
    maze [6] = ['W', ' ', 'W', 'W', 'W', 'W', 'W', 'W', ' ', 'W']
    maze [7] = ['W', ' ', 'W', 'W', 'W', 'W', 'W', 'W', ' ', 'W']
    maze [8] = ['W', ' ', 'W', 'W', 'W', 'W', 'W', 'W', ' ', 'W']
    maze [9] = ['W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'X', 'W']

def display (maze):
   r = 0
   c = 0
   print(HORIZONTAL_NUMBERS)
   for r in range (0, ROWS, 1):
      for c in range (0, COLUMNS, 1):
         sys.stdout.write(maze[r][c])
      print(" ", r)

def findExit (maze,r,c):
   done = False
   if (maze[r][c] == EXIT):
        maze[r][c] = GOOD_PATH
        done = True
   else:
        maze [r][c] = TRIED;
        # TRY NORTH
        if (maze[r-1][c] == EMPTY) or (maze[r-1][c] == EXIT):
            done = findExit (maze,r-1,c)
        if (done == False):
            # TRY WEST
            if (maze[r][c-1] == EMPTY) or (maze[r][c-1] == EXIT):
                done = findExit (maze,r,c-1)
        if (done == False):
            # TRY EAST
            if (maze[r][c+1] == EMPTY) or (maze[r][c+1] == EXIT):
                done = findExit (maze,r,c+1)
        if (done == False):
            # TRY SOUTH
            if (maze[r+1][c] == EMPTY) or (maze[r+1][c] == EXIT):
                done = findExit (maze,r+1,c)
        # Checked 4 directions, one direction had exit then mark this as part of good path
        if (done):
            maze[r][c] = GOOD_PATH;
   return done

def start (maze):
   found = False
   print("Start location (row/col) (%d/%d)" %(START_ROW,START_COLUMN))
   display(maze)

   # Starting (row/col) position in the maze is passed as a parameter.
   found = findExit (maze,START_ROW,START_COLUMN);
   if (found):
       print("Exit was found!\n")
   else:
       print("There's no exit from the maze.\n")
   display(maze)


def main ():
    maze = []
    initialize(maze)
    start(maze)

main ()
