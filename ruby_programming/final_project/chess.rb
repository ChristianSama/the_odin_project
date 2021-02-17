require_relative 'board'

class Chess
  attr_reader :board
  def initialize
    @board = Board.new
  end

  def start
    @board.print_board
    puts 'Input the position of a piece'
    coord = gets.chomp.split("")
    selected_piece = @board.data[coord[0].to_i][coord[1].to_i]
  end

end