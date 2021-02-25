require_relative 'board'

class Chess
  attr_reader :board, :selected_piece, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
  end

  def start
    @board.print_board
    while (true)
      loop do
        puts "#{@current_player}'s turn"
        puts 'Input the coordinates of a piece to select it'
        coord = gets.chomp.split("").map(&:to_i)
        if (!is_valid_coord?(coord) || !is_valid_selection?(coord))
          puts 'Invalid selection. Please try again'
          next
        end
        @selected_piece = select_piece(coord)
        break;
      end

      puts 'Input the square you want to move to'
      coord = gets.chomp.split("").map(&:to_i)
      if (!is_valid_coord?(coord) || !is_valid_move?(selected_piece, coord))
        puts 'Invalid move. Please try again'
        next
      end
      @selected_piece.move(@board, coord)
      @board.print_board
      @current_player = @current_player == :white ? :black : :white
    end
  end

  def select_piece(coord)
    piece = @board.get_piece(coord)
    piece.select(@board)
    @board.print_board
    piece.remove_dots(@board)
    return piece
  end

  def is_valid_coord?(coord)
    #if coord is empty
    return false if (coord.empty?) 
    
    #if its outside boundaries
    if (coord[0] >= @board.data.length ||
        coord[1] >= @board.data.length ||
        coord[0] < 0 ||
        coord[1] < 0)
      return false
    end

    #if there are more or less than 2 elements in coord array
    if (coord.length < 2 ||
        coord.length > 2)
      return false
    end

    return true
  end

  def is_valid_selection?(coord)
    piece = @board.get_piece(coord)
    if (piece == nil ||
        piece.color != @current_player)
      return false
    end
    return true
  end

  def is_valid_move?(piece, coord)
    #check if its in possible moves array of piece
    if (!piece.possible_moves.include?(coord))
      return false
    end
    return true
  end

  def king_in_check?
    king = @current_player == :white ? @white_king : @black_king
    pieces = @board.data.flatten.compact
    pieces.any? do |piece|
      next if piece.color == king.color
      piece.capture_set.include?([king.x, king.y])
    end
  end
end