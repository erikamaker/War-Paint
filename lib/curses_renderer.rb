# encoding: UTF-8

require 'curses'                # Require the Curses gem so we can play with terminal output and extend input options for our rendering class. 

class CursesRenderer            # Create a constant for arrow key movement. 
  MOVEMENT_KEYS = [Curses::Key::UP, Curses::Key::DOWN, Curses::Key::LEFT, Curses::Key::RIGHT].freeze            

  def initialize(board)         # Accepts one argument `board`
    @board = board              # Set value of argument to @board 
    @selected = [0, 0]          # The default square that is selected is the lower-left corner. 
  end

  def play!
    initialize_curses           # This initializes the curses module. It's not standard to the gem, but is defined later in this file. 

    loop do                     # Starts the loop that will only break if the user hits 'q' * 
      render                    # Draws the grid. See below for comments on how this method works.  

      key = @screen.getch       # I learned that `getch` is a method native to the Curses module. 
      if key == 'q' || key == 'Q'  # * 

        break
      elsif movement?(key)      # A secondary condition checks for movement (whether a MOVEMENT_KEYS was used or not)
        update_selection(key)   # Updates the location of the currently-selected cell. 
      end
    end

    deinitialize_curses         # Basically the end cap of the initialize_curses method above. It restores terminal settings. 
  end

  def render                    # This method actually renders the grid 
    cell_height = 2             # ( Using the height and width variables for each cell )
    cell_width = 4

    @board.grid.each_with_index do |row, row_index|         # Iterates through each row in the game board, and provides each row's index in the array. 
      row.each_with_index do |cell, column_index|           # This iterates over each cell in the given rows, and provides each column's index in the row. 
        box = selected?(row_index, column_index) ? selected_box : unselected_box         # Determines which box type to return at the selected intersection. 

        @screen.setpos(row_index * cell_height, column_index * cell_width)         # Curses sets the cursor to the current cell's upper-left corner. 
        @screen.addstr box[0]                               # And draws the top half of the box characters
        @screen.setpos(row_index * cell_height + 1, column_index * cell_width)      # Curses sets the cursor to the current cell's lower-left corner. 
        @screen.addstr box[1]                               # And draws the bottom half of the box characters

        # if cell.empty?
        #
        # else
        #
        # end
      end
    end

    @screen.setpos @board.height * cell_height + 1, 0         # Sets cursor below grid by multiplying (the height of the board) * (the height of each cell + 1)
    @screen.addstr "Selected: #{@selected}"                   # Output which coordinate on the grid is selected
    @screen.setpos @board.height * cell_height + 2, 0         # Sets the curosr below the the above output. 
    @screen.addstr "Use arrow keys to select or `Q` to quit"  # Tells the player to select either a new cell, or to quit. 

    @screen.refresh                                           # Updates the screen based on player decisions / updated data. 
  end

  def selected?(row, col)                                     # Using row / col to pinpoint a location on the grid, and check if a given cell is selected.
    @selected && @selected[0] == row && @selected[1] == col   # First check that @selected exists. If it does, its 0 index is checked against row, and its 1 index against col. 
  end

  def unselected_box                                          # Pretty self-explanatory 
    ["┌─┐", "└─┘"]
  end

  def selected_box                                            # Pretty self-explanatory
    ["╔═╗", "╚═╝"]
  end

  def movement?(key)                                          # Checks whether a player selected an arrow key
    MOVEMENT_KEYS.include? key
  end

  def update_selection(key)                                   # Updates selected coordinate location based on arrow key input. 
    case key
    when Curses::Key::UP
      @selected[0] -= 1 if @selected[0] > 0                   # E.G. When player selects 'up' while not at top of board ( > 0 ), Curses moves the selection up a row. 
    when Curses::Key::DOWN
      @selected[0] += 1 if @selected[0] < @board.height - 1
    when Curses::Key::LEFT
      @selected[1] -= 1 if @selected[1] > 0
    when Curses::Key::RIGHT
      @selected[1] += 1 if @selected[1] < @board.width - 1
    end
  end

  def initialize_curses 
    Curses.init_screen                                        # Initialize curses screen. 
    Curses.curs_set 0                                         # Turn off the cursor, so it doesn't blink. 
    Curses.noecho                                             # Turns off echo, so player input isn't always returned in the terminal
    Curses.start_color                                        # Allow for colorizing of output. 

    @screen = Curses.stdscr                                   # Sets @screen to the standard Curses screen (all output goes here).
    @screen.keypad = true                                     # Allows special keys like arrow keys to work.
    @screen.clear                                             # Clears the old screen before rendering the new one. 
  end

  def deinitialize_curses                                     # Exits Curses and returns the terminal to normal operating mode. 
    Curses.close_screen
  end
end
