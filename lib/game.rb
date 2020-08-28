class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end

  def play
    main_menu
    if @main_menu_response == 'p'
      # computer lays out ships
      computer_ship_placement
      player_ship_placement_prompt
      player_cruiser_placement_prompt
      player_cruiser_validation_check
      player_place_cruiser
      player_submarine_placement_prompt
      player_submarine_validation_check
      player_place_submarine
    # add elsif/else

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

  def player_cruiser_placement_prompt
    # remove me later
    # trying to display the computer board while figuring out computer ship placement
    puts @computer_board.render(true)
    # remove me later

    puts "  1 2 3 4 \n" +
         "A . . . . \n" +
         "B . . . . \n" +
         "C . . . . \n" +
         "D . . . . \n" +
         "Enter the squares for the Cruiser (3 spaces):"
    print "> "
  end

  def player_submarine_placement_prompt
    puts "Now enter the squares for the Submarine (2 spaces):"
  end

  def player_cruiser_validation_check
    loop do
      @cruiser_placement_entry = gets.chomp
      @cruiser_placement = @cruiser_placement_entry.split(" ")
      @cruiser = Ship.new("Cruiser", 3)
      if @player_board.valid_placement?(@cruiser, @cruiser_placement)
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
  end

  def player_submarine_validation_check
    loop do
      @submarine_placement_entry = gets.chomp
      @submarine_placement = @submarine_placement_entry.split(" ")
      @submarine = Ship.new("Submarine", 2)
      if @player_board.valid_placement?(@submarine, @submarine_placement)
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
  end

  def player_place_cruiser
    @player_board.place(@cruiser, @cruiser_placement)
    render_player_board
  end

  def player_place_submarine
    @player_board.place(@submarine, @submarine_placement)
    render_player_board
  end

  def render_player_board
    print @player_board.render(true)
  end

  def render_computer_board
    print @computer_board.render
  end

  # brainstorming
  def computer_ship_placement
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
    directions = ["horizontal"]
    # directions = ["horizontal", "vertical"].shuffle
    coordinates = []
    loop do
      if directions[0] == "horizontal"
        # For cruiser
        comp_cells = @computer_board.cell_names.shuffle[0..2]
        if @computer_board.valid_placement?(@comp_cruiser, comp_cells) == true
          @computer_board.place(@comp_cruiser, comp_cells)
          break
        # "A1" --> ["A1", "A2", "A3"]
      # else
      #   @computer_board.cell_names[0]
        # "A1" --> ["A1", "B1", "C1"]
        end
      end
      # run array through validation check
        # if valid
        #   break
        # if invalid
        #   start over
    end
  end
end
