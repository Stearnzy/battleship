require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

# Since we're requiring game above, no need to initialize
# game = Game.new
game.play
