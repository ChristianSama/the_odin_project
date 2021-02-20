require_relative 'board'

class Chess
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def start
    @board.print_board

    while (true)
      puts 'Input the position of a piece to select it'
      coord = gets.chomp.split("").map(&:to_i)
      selected_piece = select_piece(coord)

      puts 'Input the square you want to move to'
      coord = gets.chomp.split("").map(&:to_i)
      selected_piece.move(@board, coord)
    end
  end

  def select_piece(coord)
    piece = @board.get_piece(coord)
    piece.select(@board)
    @board.print_board
    return piece
  end
end