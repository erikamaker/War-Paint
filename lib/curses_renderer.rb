# encoding: UTF-8

require 'curses'

class CursesRenderer
  MOVEMENT_KEYS = [Curses::Key::UP, Curses::Key::DOWN, Curses::Key::LEFT, Curses::Key::RIGHT].freeze
  PAINT_KEYS = [Curses::Key::ENTER, ' ', "\n"]
  UNPAINTED = 1
  Curses.init_pair(UNPAINTED, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
  PAINTED = 2
  Curses.init_pair(PAINTED, Curses::COLOR_WHITE, Curses::COLOR_RED)


  def initialize(board)
    @board = board
    @selected = [0, 0]
  end


  def play!
    initialize_curses

    loop do
      render

      key = @screen.getch
      if key == 'q' || key == 'Q'

        break
      elsif movement?(key) || painting?(key)
        update_selection(key)
      end
    end

    deinitialize_curses
  end

  def render
    cell_height = 2
    cell_width = 4

    @board.grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        box = selected?(row_index, column_index) ? selected_box : unselected_box

        @screen.setpos(row_index * cell_height, column_index * cell_width)
        @screen.addstr box[0]
        @screen.setpos(row_index * cell_height + 1, column_index * cell_width)
        @screen.addstr box[1]


      end
    end

    @screen.setpos @board.height * cell_height + 1, 0
    @screen.addstr "Selected: #{@selected}"
    @screen.setpos @board.height * cell_height + 2, 0
    @screen.addstr "Use arrow keys to select or `Q` to quit"

    @screen.refresh
  end

  def selected?(row, col)
    @selected && @selected[0] == row && @selected[1] == col
  end

  def unselected_box
    ["┌─┐", "└─┘"]
  end

  def selected_box
    ["╔═╗", "╚═╝"]
  end

  def movement?(key)
    MOVEMENT_KEYS.include? key
  end

  def painting?(key)
    PAINT_KEYS.include? key
  end

  def update_selection(key)
    case key
    when Curses::Key::UP
      @selected[0] -= 1 if @selected[0] > 0
    when Curses::Key::DOWN
      @selected[0] += 1 if @selected[0] < @board.height - 1
    when Curses::Key::LEFT
      @selected[1] -= 1 if @selected[1] > 0
    when Curses::Key::RIGHT
      @selected[1] += 1 if @selected[1] < @board.width - 1
    when *PAINT_KEYS
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
