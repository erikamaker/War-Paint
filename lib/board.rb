class Board
  attr_reader :grid
  attr_accessor :agent

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
    agent_is_player
  end

  def agent_is_cpu
    @agent = :cpu
  end

  def agent_is_player
    @agent = :player
  end

  def whose_turn_is_it?
    print @agent
  end

  def game_over?
    @grid.flatten.all?(&:painted?)
  end

end
