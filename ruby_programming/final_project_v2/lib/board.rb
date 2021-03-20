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
    @black_king = @data[6][0].piece = King.new(:black, [6, 0])
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
    @data[row][7].piece = Rook.new(color, [row, 7])

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

  def move(piece, coord, true_move = false)
    to_square = get_square(coord)
    if (to_square.piece != nil)
      capture = to_square.piece
      #piece.captured << capture
    end
    to_square.piece = piece
    from_square = get_square(piece.position)
    from_square.piece = nil
    piece.update_position(coord)
    piece.has_moved = true if true_move == true
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
    return unexposed_moves if unexposed_moves.empty?

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

  def castle_moves(king) #could create can_castle method to simplify
    moves = []
    row = king.position[0]
    if (can_castle?(king, 1))
      col = color == :white ? 6 : 1
      moves << [row, col]
    end
    if (can_castle?(king, -1))
      col = color == :white ? 2 : 5
      moves << [row, col]
    end
    moves
  end

  def can_castle?(king, dir) #@white_king, -1 ---> can castle left?

    return false if (king.has_moved)
    return false if (king_in_check?(king.color))

    x_offset = dir == 1 ? 3 : 4
    row = king.position[0]
    col = king.position[1] + (x_offset * dir * king.direction)
    rook = get_square([row, col]).piece

    return false if (rook.has_moved)
    return false if (rook == nil)

    moves = king.linear_moves(king, [0, dir], x_offset - 1)
    moves.each do |m|
      if (!free?(m))
        return false
      end
      if (dir == -1 && m != moves.last)
        if (under_attack?(king.color, m))
          return false
        end
      end
    end
    return true
  end

  def under_attack?(color, coord) #friendly color
    squares = @data.flatten
    squares.any? do |sq|
      next if sq.piece == nil
      next if sq.piece.color == color
      sq.piece.get_possible_moves(self).include?(coord)
    end
  end

  def free?(coord)
    return true if get_square(coord).piece == nil
    return false
  end

end
