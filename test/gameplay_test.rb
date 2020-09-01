require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GamePlayTest < Minitest::Test
  def test_it_exists
    gameplay = GamePlay.new
    assert_instance_of GamePlay, gameplay
  end
end
