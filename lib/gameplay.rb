class GamePlay
  attr_reader :player_board, :computer_board, :cell_names

  def initialize(cell_names, computer_cruiser, computer_submarine, player_cruiser, player_submarine, computer_board, player_board)
    @cell_names = cell_names
    @computer_cruiser = computer_cruiser
    @computer_submarine = computer_submarine
    @player_cruiser = player_cruiser
    @player_submarine = player_submarine
    @computer_board = computer_board
    @player_board = player_board
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

  def replay_prompt
    puts "Play again? Enter p to play or q to quit."
    print "> "
  end

  def render_computer_board
    print @computer_board.render
  end

  def render_player_board
    print @player_board.render(true)
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
      if @cell_names.include?(@player_shot) && @computer_board.cells[@player_shot].fired_upon? == false
        @computer_board.cells[@player_shot].fire_upon
        break
      elsif @cell_names.include?(@player_shot) && @computer_board.cells[@player_shot].fired_upon?
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
      @computer_shot = @cell_names.shuffle[0]
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
