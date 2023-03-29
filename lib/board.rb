class Board
  attr_reader :rows, :cols
  def initialize(rows,cols)
    @rows, @cols = rows, cols
  end
  def grid(square_type)
    Array.new(rows) {Array.new(cols, square_type) }        # Make 2D array (for each @row, a square is printed based on what preset is selected).
  end
end
