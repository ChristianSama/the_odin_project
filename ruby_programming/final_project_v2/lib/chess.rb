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
      puts 'Input the coordinates of a piece to select it for example: D2'
      loop do
        input = gets.chomp
        if (!valid_coordinate?(input))
          puts 'Invalid coordinate. Try again'
          next
        elsif (!valid_selection?(translate(input)))
          puts 'Invalid selection. Try selecting one of your pieces'
          next
        end
        @board.select_piece(translate(input))
        break
      end
      @board.print_board
      puts 'Input the coordinates of a square to move'
      loop do
        input = gets.chomp
        if (!valid_coordinate?(input))
          puts 'Invalid coordinate. Try again'
          next
        elsif (!valid_move?(translate(input)))
          puts 'Invalid move. Try again'
          next
        end
        @board.move(translate(input))
        break
      end
      @current_player = @current_player == :white ? :black : :white
    end
  end

  def valid_coordinate?(alg_notation)
    return true if alg_notation.match?(/^[a-h][1-8]$/i)
    return false
  end

  def valid_selection?(coord)
    piece = @board.get_square(coord).piece
    (piece != nil && piece.color == @current_player) ? true : false
  end

  

  def valid_move?(coord)
    #it's a coord from piece.moveset
    if (@board.selected_piece.move_set.includes?(coord))
      return true
    end
    #doesn't have pieces inbetween (except knight)
    #if piece is captured, remove it
    #if under check must remove check
    #it must not expose check
    #if piece is pawn and reaches back rank, promote
    #if move is a castle
    #if move is checkmate or stalemate gameover
  end

  def move(coord)
    @selected_piece.has_moved == true
  end

  def translate(alg_notation)
    coord = alg_notation.split("")
    temp = coord[0] #a
    coord[0] = coord[1].to_i - 1
    coord[1] = temp.downcase.ord - ('a'.ord)
    return coord
  end
end

game = Chess.new
game.start