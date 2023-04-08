class Cell
  attr_accessor :painted
  def initialize
    @painted = false
  end
  def empty?
    @painted == false
  end
  def painted?
    @painted == true
  end
end
