class TerminalRenderer
  def initialize(board)
    @board = board
  end

  def play!
    loop do
      display
      print "Select `Q` to Quit
      
      >>  "
      input = gets.chomp.downcase
      break if input == 'q'
    end
  end

  def display
    for row in @board.grid
      for cell in row
        if cell.empty?
          print empty_square
        else
          print filled_square
        end
      end
      print "\n"
    end
  end

  def empty_square
    "⬚ "
  end

  def filled_square
    "█ "
  end
end
