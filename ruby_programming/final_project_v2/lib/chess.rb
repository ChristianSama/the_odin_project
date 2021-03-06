require_relative 'board'

class Chess
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
  end

  def start
    while(true)
      system "cls"
      @board.print_board
      puts "#{@current_player}'s turn"
      puts 'Input the coordinates of a piece to select it. for example: D2'
      loop do
        input = gets.chomp
        if (!valid_coordinate?(input))
          puts 'Invalid coordinate. Try again'
          next
        end
        @board.select_piece(translate(input))
      end
    end
  end

  def valid_coordinate?(alg_notation)
    return true if alg_notation.match?(/^[a-h][1-8]$/i)
    return false
  end

  def valid_selection?

  end

  def translate(alg_notation)
    coord = alg_notation.split("")
    temp = coord[0] #a
    coord[0] = coord[1].to_i - 1
    coord[1] = temp.downcase.ord - ('a'.ord)
    p coord
    return coord
  end
end

game = Chess.new
game.start