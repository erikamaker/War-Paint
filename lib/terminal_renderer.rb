class TerminalRenderer
  def initialize(board)
    @board = board
  end

  def play!
    loop do
      display(@board.grid(empty_square))      # Curses instance creates a grid of the preset for empty squares, defined in Curses.
      print "Select `Q` to Quit  >>  "                         # Prompt for...
      input = gets.chomp.downcase                              # ... and accept input.
      break if input == 'q'                                    # Exit program.
    end
  end

  def display(squares)
    squares.each {|row| puts row.join}                     # For each element in coords, join as a string and output it with a new line.
  end

  def empty_square
    "⬚ "
  end
end
