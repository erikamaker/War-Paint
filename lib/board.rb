class Board
  attr_reader :grid
  attr_accessor :current_player

  def initialize(rows, cols)
    @grid = Array.new(rows) { Array.new(cols) { Cell.new } }
    @current_player = :player
  end

  def height
    @grid.length
  end

  def width
    @grid.first.length
  end

  def paint!(row, col, player)
    @grid[row][col].paint!(player)
    @current_player = (player == :player) ? :cpu : :player
  end

  def player_turn?
    @current_player == :player
  end

  def cpu_turn?
    @current_player == :cpu
  end

  def game_over?
    @grid.flatten.all?(&:painted?)
  end
end
