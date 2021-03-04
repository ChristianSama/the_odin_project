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
      coord = gets.chomp.split("").map(&:to_i)
      
    end

  end

  def valid_coordinate?()
    
  end
end