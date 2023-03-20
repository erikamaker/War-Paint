require_relative 'test_helper'

class HelloTest < Minitest::Test
  def test_it_says_hello_world
    assert_equal "Hello world!", Hello::hello_world
  end
end
