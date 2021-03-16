require_relative 'square'
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  
  attr_reader :data, :white_king, :black_king
  attr_accessor :selected_piece

  def initialize
    @data = Array.new(8) {Array.new(8) {Square.new}}
    setup_pieces(:white)
    setup_pieces(:black)
    @white_king = @data[0][4].piece = King.new(:white, [0, 4])
    @black_king = @data[7][3].piece = King.new(:black, [7, 3])
    @data[1][5].piece = Bishop.new(:white, [1, 5])
    @data[3][7].piece = Bishop.new(:black, [3, 7])
  end

  def setup_pieces(color)
    row = color == :white ? 0 : 7
    # @data[row][0].piece = Rook.new(color)
    # @data[row][1].piece = Knight.new(color)
    # @data[row][2].piece = Bishop.new(color, [row, 2])
    # @data[row][3].piece = Queen.new(color)
    # @data[row][5].piece = Bishop.new(color, [row, 5])
    # @data[row][6].piece = Knight.new(color)
    # @data[row][7].piece = Rook.new(color)

    # row = color == :white ? 1 : 6
    # 8.times do |i|
    #   @data[row][i].piece = Pawn.new(color, [row, i])
    # end
  end

  def print_board
    @data.reverse.each_with_index do |row, i|
      #print divider
      print '   '
      8.times {print '+---'}
      puts '+'
      #print row
      print " #{8 - i} "
      row.each do |square|
        if (square.piece == nil)
          if (square.marked)
            print "| #{square.mark} "
            next
          end
          print "|   "
        else
          if (square.marked)
            print "|(#{square.piece})"
            next
          end
          print "| #{square.piece} "
        end
      end
      puts '|'
    end
    #print bottom divider
    print '   '
    8.times {print '+---'}
    puts '+'
    #print bottom legend
    puts '     A   B   C   D   E   F   G   H'
  end

  def select_piece(coord)
    @selected_piece = get_square(coord).piece
    valid_moves = get_unexposed_moves(@selected_piece)
    mark_moves(valid_moves)
  end

  def get_square(coord)
    return @data[coord[0]][coord[1]]
  end

  def inside_board?(coord)
    if (coord[0] >= 0 && coord[0] <= 7 &&
        coord[1] >= 0 && coord[1] <= 7)
      return true
    else
      return false
    end
  end

  def move(piece, coord)
    to_square = get_square(coord)
    if (to_square.piece != nil)
      capture = to_square.piece
      #piece.captured << capture
    end
    to_square.piece = piece
    from_square = get_square(piece.position)
    from_square.piece = nil
    piece.update_position(coord)
    piece.has_moved == true
    capture
  end

  def mark_moves(moves)
    moves.each do |move|
      square = get_square(move)
      square.marked = true
    end
  end

  def unmark_moves
    @data.flatten.each do |square|
      square.marked = false
    end
  end

  def get_unexposed_moves(piece)
    init_pos = [piece.position[0], piece.position[1]]
    unexposed_moves = piece.get_possible_moves(self)
    i = 0
    loop do
      m = unexposed_moves[i]
      captured_piece = move(piece, m)
      if (king_in_check?(piece.color))
        unexposed_moves.delete(m)
        i -= 1
      end
      if (captured_piece)
        get_square(m).piece = captured_piece
      else
        get_square(m).piece = nil
      end
      piece.update_position(init_pos)
      i += 1
      break if i >= unexposed_moves.length
    end
    get_square(init_pos).piece = piece
    unexposed_moves
  end

  def king_in_check?(color)
    king = color == :white ? @white_king : @black_king
    squares = @data.flatten
    squares.any? do |sq|
      next if sq.piece == nil
      next if sq.piece.color == color
      sq.piece.get_possible_moves(self).include?(king.position)
    end
  end

  # def get_capturable_pieces(moves)
  #   pieces = []
  #   moves.each do |move|
  #     piece = get_square(move).piece  
  #     pieces << piece
  #   end
  #   pieces
  # end

end
