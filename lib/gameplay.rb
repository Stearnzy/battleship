class GamePlay
  attr_reader :player_board, :computer_board, :cell_names

  def initialize(cell_names, computer_board, player_board)
    @cell_names = cell_names
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
    victory_prompt
  end

  def game_is_still_going?
    @player_board.render(true).include?("S") && @computer_board.render(true).include?("S")
  end

  def victory_prompt
    if computer_won?
      puts "Sorry player, I win!"
    elsif player_won?
      puts "Congratulations player, you win!!!"
    end
  end

  def player_won?
    @player_board.render(true).include?("S") && !@computer_board.render(true).include?("S")
  end

  def computer_won?
    @computer_board.render(true).include?("S") && !@player_board.render(true).include?("S")
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
        turn_player_shot(@player_shot)
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

  def turn_player_shot(player_shot)
    @computer_board.cells[player_shot].fire_upon
  end

  def turn_computer_shot
    if !@player_board.render(true).include? "H"
      hunt
    elsif @player_board.render(true).count("H") == 1
      target
    else # MORE THAN ONE "H"
      finish_him
    end
  end

  def hunt
    loop do
      @computer_shot = @cell_names.shuffle[0]
      if @player_board.cells[@computer_shot].fired_upon? == false
        @player_board.cells[@computer_shot].fire_upon
        break
      end
    end
  end

  def target
    identify_hit_cell
    map_surrounding_cells
    @computer_shot = @surrounding_cells.shuffle[0]
    @player_board.cells[@computer_shot].fire_upon
  end

  def identify_hit_cell
    @hit_cell = @player_board.cells.find do |name, cell|
      cell.render == "H"
    end
  end

  def map_surrounding_cells
    @surrounding_cells = []
    split_hit_cell = @hit_cell[0].split("")
    @surrounding_cells << split_hit_cell[0] + (split_hit_cell[1].to_i - 1).to_s
    @surrounding_cells << split_hit_cell[0] + (split_hit_cell[1].to_i + 1).to_s
    @surrounding_cells << (split_hit_cell[0].ord - 1).chr + split_hit_cell[1]
    @surrounding_cells << (split_hit_cell[0].ord + 1).chr + split_hit_cell[1]
    @surrounding_cells.each do |cell|
      if !player_board.cell_names.include? cell
        @surrounding_cells.delete(cell)
      elsif player_board.cells[cell].fired_upon?
        @surrounding_cells.delete(cell)
      end
    end
    @surrounding_cells
  end

  # def finish_him
  #   identify_hit_cells
  # end
  #
  # def identify_hit_cells
  #   @hit_cells = @player_board.cells.find do |name, cell|
  #     cell.render == "H"
  #   end
  # end
  #
  # def adjacent_vertical?
  #   hit_cell_row = @hit_cells.map do |cell|
  #     cell[0]
  #   end
  # end

  def adjacent_horizontal?

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
