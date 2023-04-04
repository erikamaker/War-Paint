class Board                 
  attr_reader :grid                                             # Creates getter  method for @grid.

  def initialize(rows, cols)                                    # Constructs a new Board instance with supplied rows and cols. 
    @grid = Array.new(rows) {Array.new(cols, Cell.new) }        # A 2D array is constructed at initialization, using `rows` for number of rows.
  end                                                           # A block performed on each row and adds a cell for each number of cols. 

  def height
    @grid.length                                                # The height is defined as the length of the entire 2D array.
  end

  def width                                                                  
    @grid.first.length                                          # The length of the first row is the width, defined here. 
  end
end


