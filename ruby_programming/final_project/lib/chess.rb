require_relative 'board'

class Chess
  attr_reader :board, :selected_piece

  def initialize
    @board = Board.new
  end

  def start
    @board.print_board

    while (true)
      loop do
        puts 'Input the coordinates of a piece to select it'
        coord = gets.chomp.split("").map(&:to_i)
        if (!is_valid_coord?(coord))
          puts 'Invalid coordinates. Please try again'
          next
        end
        @selected_piece = select_piece(coord)
        break;
      end

      puts 'Input the square you want to move to'
      coord = gets.chomp.split("").map(&:to_i)
      if (!is_valid_coord?(coord))
        puts 'Invalid coordinates. Please try again'
        next
      end
      @selected_piece.move(@board, coord)
    end
  end

  def select_piece(coord)
    piece = @board.get_piece(coord)
    return nil if piece == nil
    piece.select(@board)
    @board.print_board
    return piece
  end

  def is_valid_coord?(coord)
    #if its empty
    return false if (coord.empty?) 
    
    #if its outside boundaries
    if (coord[0] >= @board.data.length ||
        coord[1] >= @board.data.length ||
        coord[0] < 0 ||
        coord[1] < 0)
      return false
    end

    #if there are more or less than 2 elements in coordinate
    if (coord.length < 2 ||
        coord.length > 2)
      return false
    end
    return true
  end
end