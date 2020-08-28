class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end

  def play
    loop do
      game_setup
      turns
    end
  end

  def game_setup
    main_menu_prompt
    verify_main_menu_response
    computer_ship_placement
    player_ship_placement_prompt
    player_cruiser_placement_prompt
    player_cruiser_validation_check
    player_place_cruiser
    player_submarine_placement_prompt
    player_submarine_validation_check
    player_place_submarine
  end

  def turns
    loop do
      board_display
      turn_player_shot_prompt
      turn_validate_player_shot
      stringify_player_results
      player_results
      if !game_is_still_going?
        break
      end
      turn_computer_shot
      stringify_computer_results
      computer_results
      if !game_is_still_going?
        break
      end
    end
    board_display
    victory
  end

  def game_is_still_going?
    @player_board.render(true).include?("S") && @computer_board.render(true).include?("S")
  end

  def victory
    if @computer_board.render(true).include?("S")
      puts "Sorry player, I win!"
    elsif @player_board.render(true).include?("S")
      puts "Congratulations player, you win!!!"
    end
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

  def player_ship_placement_prompt
    puts "I have laid out my ships on the grid.\n" +
          "You now need to lay out your two ships.\n" +
          "The Cruiser is three units long and the Submarine is two units long.\n"
  end

  def player_cruiser_placement_prompt
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

  def computer_ship_placement
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
    loop do
      comp_cells = @computer_board.cell_names.shuffle[0..2]
      if @computer_board.valid_placement?(@comp_cruiser, comp_cells) == true
        @computer_board.place(@comp_cruiser, comp_cells)
        break
      end
    end

    loop do
      comp_cells = @computer_board.cell_names.shuffle[0..1]
      if @computer_board.valid_placement?(@comp_submarine, comp_cells) == true
        @computer_board.place(@comp_submarine, comp_cells)
        break
      end
    end
  end

  def board_display
    puts "=============COMPUTER BOARD============="
    render_computer_board
    puts "==============PLAYER BOARD=============="
    render_player_board
  end

  def turn_player_shot_prompt
    puts "Enter the coordinate for your shot:"
    print "> "
  end

  def turn_validate_player_shot
    loop do
      @player_shot = gets.chomp.upcase
      if @computer_board.cell_names.include?(@player_shot) && @computer_board.cells[@player_shot].fired_upon? == false
        @computer_board.cells[@player_shot].fire_upon
        break
      elsif @computer_board.cell_names.include?(@player_shot) && @computer_board.cells[@player_shot].fired_upon?
        puts "You already shot at #{@player_shot}. Try another coordinate:"
        print "> "
      else
        puts "Please enter a valid coordinate:"
        print "> "
      end
    end
  end

  def turn_computer_shot
    loop do
      @computer_shot = @player_board.cell_names.shuffle[0]
      if @player_board.cells[@computer_shot].fired_upon? == false
        @player_board.cells[@computer_shot].fire_upon
        break
      end
    end
  end

  def stringify_player_results
    if @computer_board.cells[@player_shot].render == "H"
      @player_result = "HIT."
    elsif @computer_board.cells[@player_shot].render == "M"
      @player_result = "MISS."
    else
      @player_result = "HIT"
      @ship_sunk_by_player = "#{@computer_board.cells[@player_shot].ship.name}"
    end
  end

  def stringify_computer_results
    if @player_board.cells[@computer_shot].render == "H"
      @computer_result = "HIT."
    elsif @player_board.cells[@computer_shot].render == "M"
      @computer_result = "MISS."
    else
      @computer_result = "HIT"
      @ship_sunk_by_computer = "#{@player_board.cells[@computer_shot].ship.name}"
    end
  end

  def player_results
    if @player_result == "HIT"
      puts "Your shot on #{@player_shot} was a HIT.\n" +
           "You sunk my #{@ship_sunk_by_player}!!"
    else
      puts "Your shot on #{@player_shot} was a #{@player_result}"
    end
  end

  def computer_results
    if @computer_result == "HIT"
      puts "My shot on #{@computer_shot} was a HIT.\n" +
           "I sunk your #{@ship_sunk_by_computer}!!"
    else
      puts "My shot on #{@computer_shot} was a #{@computer_result}"
    end
  end
end
