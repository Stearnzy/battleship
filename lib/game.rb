
class Game

  def play
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    print "> "

    if gets.chomp.downcase == "q"
      p "Goodbye"
    elsif gets.chomp.downcase == "p"
      p "hi"

    end
  end
end
