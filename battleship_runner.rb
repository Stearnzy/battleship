require './lib/ship'
require './lib/cell'
require './lib/cell_generator'
require './lib/board'
require './lib/gameplay'
require './lib/game_setup'

# game = Game.new
# game.play


setup = GameSetup.new
setup.setup
gameplay = Game.new(setup.cell_names, setup.height, setup.width)
# setup.placement
# gameplay.computer_ship_placement
gameplay.play