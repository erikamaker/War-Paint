require_relative 'test_helper'

class BoardTest < Minitest::Test
  def test_a_board_has_the_right_number_of_rows
    assert_equal 5, Board.new(5, 4).grid.size
  end

  def test_a_board_has_the_right_number_of_columns
    assert_equal 4, Board.new(5, 4).grid.first.size
  end

  def test_a_board_has_the_same_number_of_cells_in_each_row
    board = Board.new(5, 4)
    assert board.grid.all? { |row| row.size == 4 }
  end
end
