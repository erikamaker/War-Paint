class Cell
  def initialize
    @painted = false
  end

  def painted?
    @painted == true
  end

  def paint!
    @painted = true
  end

end
