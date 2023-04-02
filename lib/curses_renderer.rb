# encoding: UTF-8

require 'curses'

class CursesRenderer
  MOVEMENT_KEYS = [Curses::Key::UP, Curses::Key::DOWN, Curses::Key::LEFT, Curses::Key::RIGHT].freeze

  def initialize(board)
    @board = board
    @selected = [0, 0]
  end

  def play!
    initialize_curses

    loop do
      render

      key = @screen.getch
      if key == 'q'
        break
      elsif movement?(key)
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

        # if cell.empty?
        #
        # else
        #
        # end
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
    end
  end

  def initialize_curses
    Curses.init_screen
    Curses.curs_set 0
    Curses.noecho
    Curses.start_color

    @screen = Curses.stdscr
    @screen.keypad = true
    @screen.clear
  end

  def deinitialize_curses
    Curses.close_screen
  end
end