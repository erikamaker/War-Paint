class Board
  attr_reader :grid

  def initialize(rows, cols)
    @grid = Array.new(rows) {Array.new(cols, Cell.new) }
  end
end
