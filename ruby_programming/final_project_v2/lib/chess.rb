class Chess

  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
  end

  def start
    while(true)
      @board.print_board
      puts "#{@current_player}'s turn"
      puts 'Input the coordinates of a piece to select it'
      coord = gets.chomp
      
      
    end
  end

  def valid_coordinate?(str)
    return true if str.match?(/^[a-h][1-8]$/i)
    return false
  end

  def translator(str)
    coord = str.split("").map(&:to_i)

  end
end