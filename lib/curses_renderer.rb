# encoding: UTF-8

require 'curses'

class CursesRenderer
  MOVEMENT_KEYS = [Curses::Key::UP, Curses::Key::DOWN, Curses::Key::LEFT, Curses::Key::RIGHT].freeze
  PAINT_KEYS = [Curses::Key::ENTER, ' ', "\n"]
  UNPAINTED_COLOR = 1
  PAINTED_COLOR = 2
  CELL_HEIGHT = 2
  CELL_WIDTH = 4

  def initialize(board)
    @board = board
    @selected = [0, 0]
    @cpu_player = Cpu.new(board)
  end

  def show_game_over_screen
    Curses.addstr("\n\nGAME OVER!\n\n")
    Curses.refresh
    sleep(3)
  end

  def play!
    initialize_curses

    loop do
      render

      if @board.game_over?
        show_game_over_screen
        break
      end

      key = @screen.getch
      if key == 'q' || key == 'Q'

        break
      elsif movement?(key)
        update_selection(key)
      elsif painting?(key)
        @board.paint!(@selected[0], @selected[1])
        @cpu_player.cpus_turn
      end
    end

    deinitialize_curses
  end

  def render
    draw_board
    draw_instructions
    @screen.refresh
  end


  def draw_board
    @board.grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        draw_cell(cell, row_index, column_index)
      end
    end
  end

  def draw_cell(cell, row, col)
    box = selected?(row, col) ? selected_box : unselected_box
    color = cell.painted? ? PAINTED_COLOR : UNPAINTED_COLOR

    @screen.attron(Curses.color_pair(color))
    @screen.setpos(row * CELL_HEIGHT, col * CELL_WIDTH)
    @screen.addstr box[0]
    @screen.setpos(row * CELL_HEIGHT + 1, col * CELL_WIDTH)
    @screen.addstr box[1]
    @screen.attroff(Curses.color_pair(color))
  end

  def draw_instructions
    @screen.setpos @board.height * CELL_HEIGHT + 1, 0
    @screen.addstr "Selected: #{@selected}"
    @screen.setpos @board.height * CELL_HEIGHT + 2, 0
    @screen.addstr "Use arrow keys to select or `Q` to quit"
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
    end
  end

  def initialize_curses
    Curses.init_screen
    Curses.curs_set 0
    Curses.noecho
    Curses.start_color
    Curses.init_pair(UNPAINTED_COLOR, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
    Curses.init_pair(PAINTED_COLOR, Curses::COLOR_WHITE, Curses::COLOR_RED)

    @screen = Curses.stdscr
    @screen.keypad = true
    @screen.clear
  end

  def deinitialize_curses
    Curses.close_screen
  end
end
