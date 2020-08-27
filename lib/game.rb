class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end
  # def play
  #   p "Welcome to BATTLESHIP"
  #   p "Enter p to play. Enter q to quit."
  #   print "> "
  #
  #   if gets.chomp.downcase == "q"
  #     p "Goodbye"
  #   elsif gets.chomp.downcase == "p"
  #     p "hi"
  #   else
  #     p "Invalid command."
  #   end
  # end

  def play
    main_menu
    if @main_menu_response == 'p'
      # computer lays out ships
      player_ship_placement_prompt
      cruiser_placement_prompt
      cruiser_validation_check
      # place cruiser
      # render board
      # sub validation check
    end
  end

  def main_menu
    puts  "Welcome to BATTLESHIP\n" +
          "Enter p to play. Enter q to quit.\n"
    print "> "
    @main_menu_response = gets.chomp.downcase
  end

  def player_ship_placement_prompt
    puts "I have laid out my ships on the grid.\n" +
          "You now need to lay out your two ships.\n" +
          "The Cruiser is three units long and the Submarine is two units long.\n"
  end

  def cruiser_placement_prompt
    puts "  1 2 3 4 \n" +
         "A . . . . \n" +
         "B . . . . \n" +
         "C . . . . \n" +
         "D . . . . \n" +
         "Enter the squares for the Cruiser (3 spaces):"
    print "> "
  end

  def cruiser_validation_check
    loop do
      @cruiser_placement = gets.chomp
      @cruiser_placement = @cruiser_placement.split(" ")
      cruiser = Ship.new("Cruiser", 3)
      if @player_board.valid_placement?(cruiser, @cruiser_placement)
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
  end

  def place_cruiser

  end

  def submarine_placement_prompt
    puts "  1 2 3 4
          A S S S .
          B . . . .
          C . . . .
          D . . . .
          Enter the squares for the Submarine (2 spaces):
          >"
  end
end
