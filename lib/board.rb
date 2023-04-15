class Board
  attr_reader :grid

  def initialize(rows, cols)
    @grid = Array.new(rows) { Array.new(cols) { Cell.new } }
  end

  def height
    @grid.length
  end

  def width
    @grid.first.length
  end

  def paint!(row, col)
    @grid[row][col].paint!
  end

  def game_over?
    @grid.flatten.all? { |cell| cell.painted? }
  end

end
