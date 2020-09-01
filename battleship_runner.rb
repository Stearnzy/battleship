require './lib/ship'
require './lib/cell'
require './lib/cell_generator'
require './lib/board'
require './lib/gameplay'
require './lib/game_setup'

setup = GameSetup.new
setup.main_menu
loop do
  setup.setup
  setup.placement
  gameplay = GamePlay.new(setup.cell_names, setup.computer_cruiser, setup.computer_submarine, setup.player_place_cruiser, setup.player_submarine, setup.computer_board, setup.player_board)
  gameplay.turns
  setup.replay
end