class GameSetup
  attr_reader :cell_names, :height, :width, :computer_board, :player_board
  def initialize
  end

  def main_menu
    main_menu_prompt
    verify_main_menu_response
  end

  def setup
    board_size_prompt
    generate_cell_names
    create_boards
  end

  def placement
    computer_ship_placement
    player_ship_placement_prompt
    player_cruiser_placement_prompt
    player_cruiser_validation_check
    player_place_cruiser
    render_player_board
    player_submarine_placement_prompt
    player_submarine_validation_check
    player_place_submarine
  end

  def replay
    replay_prompt
    verify_main_menu_response
  end

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
    puts "Would you like to play with the standard 4x4 board? (y/n)"
    print "> "
    loop do
      size_response = gets.chomp.downcase
      if size_response == "y"
        puts "Great! 4 x 4 board initializing..."
        @height = 4
        @width = 4
        break
      elsif size_response == "n"
        puts "Sure. What board height would you like to play on?"
        print "> "
        loop do
          @height = gets.chomp.to_i
          if valid_height?(@height)
            break
          else
            puts "Sorry, #{@height} is not a valid height. Please input 1 - 9."
            print "> "
          end
        end
        puts "What board width would you like to play on?"
        print "> "
        loop do
          @width = gets.chomp.to_i
          if valid_width?(@width)
            break
          else
            puts "Sorry, #{@width} is not a valid width. Please input 1 - 9."
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
  end

  def valid_height?(height)
    (1..9).to_a.include? height
  end

  def valid_width?(width)
    (1..9).to_a.include? width
  end

  def generate_cell_names
    board_specs = CellGenerator.new(@height, @width)
    board_specs.populate_cell_names
    @cell_names = board_specs.cell_names
  end

  def create_boards
    @player_board = Board.new(@cell_names, @height, @width)
    @computer_board = Board.new(@cell_names, @height, @width)
  end

  def computer_ship_placement
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
    loop do
      randomize_computer_cruiser_cells(@cell_names)
      if @computer_board.valid_placement?(@comp_cruiser, @comp_cruiser_cells) == true
        @computer_board.place(@comp_cruiser, @comp_cruiser_cells)
        break
      end
    end

    loop do
      randomize_computer_sub_cells(@cell_names)
      if @computer_board.valid_placement?(@comp_submarine, @comp_sub_cells) == true
        @computer_board.place(@comp_submarine, @comp_sub_cells)
        break
      end
    end
  end

  def randomize_computer_cruiser_cells(cell_names)
    @comp_cruiser_cells = cell_names.shuffle[0..2]
  end

  def randomize_computer_sub_cells(cell_names)
    @comp_sub_cells = cell_names.shuffle[0..1]
  end

  def player_ship_placement_prompt
    puts "I have laid out my ships on the grid.\n" +
          "You now need to lay out your two ships.\n" +
          "The Cruiser is three units long and the Submarine is two units long.\n"
  end

  def player_cruiser_placement_prompt
    render_player_board
    puts "Enter the squares for the Cruiser (3 spaces):"
    print "> "
  end

  def player_cruiser_validation_check
    loop do
      @cruiser_placement_entry = gets.chomp.upcase
      @cruiser_placement = @cruiser_placement_entry.split(" ")
      @cruiser = Ship.new("Cruiser", 3)
      if @player_board.valid_placement?(@cruiser, @cruiser_placement)
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
  end

  def player_place_cruiser
    @player_board.place(@cruiser, @cruiser_placement)
  end

  def player_submarine_placement_prompt
    puts "Now enter the squares for the Submarine (2 spaces):"
    print "> "
  end

  def player_submarine_validation_check
    loop do
      @submarine_placement_entry = gets.chomp.upcase
      @submarine_placement = @submarine_placement_entry.split(" ")
      @submarine = Ship.new("Submarine", 2)
      if @player_board.valid_placement?(@submarine, @submarine_placement)
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
  end

  def player_place_submarine
    @player_board.place(@submarine, @submarine_placement)
  end

  def render_player_board
    print @player_board.render(true)
  end

  def replay_prompt
    puts "Play again? Enter p to play or q to quit."
    print "> "
  end
end