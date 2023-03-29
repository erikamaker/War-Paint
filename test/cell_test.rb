require_relative 'test_helper'

class CellTest < Minitest::Test
  def test_a_new_cell_is_empty
    assert_predicate Cell.new, :empty?
  end
end
