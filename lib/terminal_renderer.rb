class TerminalRenderer
  def display(squares)
    squares.each {|row| puts row.join}                     # For each element in coords, join as a string and output it with a new line.
  end
  def empty_square
    "⬚ "
  end
end
