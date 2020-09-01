class GameSetup
  attr_reader :cell_names, :height, :width
  def initialize
  end

  def setup
    main_menu_prompt
    verify_main_menu_response
    board_size_prompt
  end

  # def placement
  #   computer_ship_placement
  player_ship_placement_prompt
  player_cruiser_placement_prompt
  player_cruiser_validation_check
  player_place_cruiser
  player_submarine_placement_prompt
  player_submarine_validation_check
  player_place_submarine
  # end

  def main_menu_prompt
    puts  "Welcome to BATTLESHIP\n" +
          "Enter p to play. Enter q to quit.\n"
    print "> "
  end

  def verify_main_menu_response
    loop do
      @main_menu_response = gets.chomp.downcase
      if @main_menu_response == 'p'
        break
      elsif @main_menu_response == 'q'
        abort
      else
        puts "Sorry, #{@main_menu_response} is not a valid command.\n" +
             "Try typing p or q!"
        print "> "
      end
    end
  end

  def board_size_prompt
    puts "Would you like to play with the standard 4x4 board? (y/n)\n" +
         "> "
    loop do
      size_response = gets.chomp.downcase
      if size_response == "y"
        puts "Great! 4 x 4 board initializing..."
        @height = 4
        @width = 4
        break
      elsif size_response == "n"
        puts "Sure. What board height would you like to play on?\n" +
             "> "
        loop do
          @height = gets.chomp.to_i
          if (1..9).to_a.include? @height
            break
          else
            puts "Sorry, #{@height} is not a valid height. Please input 1 - 9."
            print "> "
          end
        end
        puts "What board width would you like to play on?\n" +
             "> "
        loop do
          @width = gets.chomp.to_i
          if (1..9).to_a.include? @width
            break
          else
            puts "Sorry, #{@height} is not a valid height. Please input 1 - 9."
            print "> "
          end
        end
        puts "Great! #{@height} x #{@width} board initializing..."
        break
      else
        puts "Sorry, #{size_response} is not a valid command.\n" +
             "Type 'y' for 4 x 4 board, or 'n' to pick a different size."
      end
    end
      board_specs = CellGenerator.new(@height, @width)
      board_specs.populate_cell_names
      @cell_names = board_specs.cell_names
  end

  # def computer_ship_placement
  #   @comp_cruiser = Ship.new("Cruiser", 3)
  #   @comp_submarine = Ship.new("Submarine", 2)
  #   loop do
  #     comp_cells = @cell_names.shuffle[0..2]
  #     if @computer_board.valid_placement?(@comp_cruiser, comp_cells) == true
  #       @computer_board.place(@comp_cruiser, comp_cells)
  #       break
  #     end
  #   end
  #
  #   loop do
  #     comp_cells = @cell_names.shuffle[0..1]
  #     if @computer_board.valid_placement?(@comp_submarine, comp_cells) == true
  #       @computer_board.place(@comp_submarine, comp_cells)
  #       break
  #     end
  #   end
  # end
end