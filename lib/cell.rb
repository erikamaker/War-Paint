class Cell
  attr_accessor :painted_by

  def initialize
    @painted_by = nil
  end

  def painted?
    !!@painted_by
  end

  def paint!(player)
    @painted_by = player
  end
end
