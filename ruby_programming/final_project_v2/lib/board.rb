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
    @white_king = @data[0][6].piece = King.new(:white, [0, 6])
    @black_king = @data[6][0].piece = King.new(:black, [6, 0])
    # @data[4][3].piece = Bishop.new(:black, [4, 3])
    # @data[0][5].piece = Bishop.new(:white, [0, 5])
    @data[7][5].piece = Rook.new(:black, [7, 5])
    @data[1][0].piece = Rook.new(:black, [1, 0])
    @data[0][4].piece = Queen.new(:white, [0, 4])
    @data[0][5].piece = Knight.new(:white, [0, 5])
    @data[6][3].piece = Pawn.new(:black, [6, 3])

    # pawn1 = Pawn.new(:black, [3, 5])
    # pawn1.has_moved = true
    # @data[3][5].piece = pawn1

    pawn2 = Pawn.new(:white, [6, 4])
    @data[6][4].piece = pawn2
    pawn2.has_moved = true

  end

  def setup_pieces(color)
    row = color == :white ? 0 : 7
    # @data[row][0].piece = Rook.new(color, [row, 0])
    # @data[row][1].piece = Knight.new(color)
    # @data[row][2].piece = Bishop.new(color, [row, 2])
    # @data[row][3].piece = Queen.new(color)
    # @data[row][5].piece = Bishop.new(color, [row, 5])
    # @data[row][6].piece = Knight.new(color)
    # @data[row][7].piece = Rook.new(color, [row, 7])

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
    piece = get_square(coord).piece
    @selected_piece = piece
    return piece
  end

  def get_square(coord)
    return @data[coord[0]][coord[1]]
  end

  def change_position(piece, coord)
    to_square = get_square(coord)
    if (to_square.piece != nil)
      capture = to_square.piece
    end
    
    to_square.piece = piece
    from_square = get_square(piece.position)
    from_square.piece = nil
    
    piece.update_position(coord)
    capture
  end

  def castle

  end

  def en_passant?(piece, coord)
    return false if (!piece.is_a?(Pawn))
    if (!piece.has_moved)
      if (coord[0] == piece.position[0] + (2 * piece.direction))
        adjacent_pawns = []
        adjacent_pawns << get_square([coord[0], coord[1] + 1]).piece
        adjacent_pawns << get_square([coord[0], coord[1] - 1]).piece
        return true if !adjacent_pawns.compact.empty?
      end
    end
    return false
  end

  def give_en_passant(piece, coord)
    adjacent_pawns = []
    adjacent_pawns << get_square([coord[0], coord[1] + 1]).piece
    adjacent_pawns << get_square([coord[0], coord[1] - 1]).piece

    adjacent_pawns.compact.each do |pawn|
      cap_coord = [piece.position[0] + (1 * piece.direction), piece.position[1]]
      pawn.en_passant_capture = cap_coord
    end
  end

  def capture_en_passant(piece, coord)
    get_square([coord[0] - (1 * piece.direction), coord[1]]).piece = nil
  end

  def remove_en_passant(color)
    pieces = @data.flatten.map { |sq| sq.piece}
    pieces.compact!.filter! { |piece| piece.is_a?(Pawn) && piece.color == color}
    pieces.each do |piece|
      piece.en_passant_capture = nil
    end
  end

  def pawn_last_rank?(piece)
    return false if !piece.is_a?(Pawn)
    last_rank = :white ? 7 : 0
    if piece.position[0] == last_rank
      return true
    end
    return false
  end

  def promote_pawn(pawn, new_piece)
    new_piece.position = pawn.position
    get_square(pawn.position).piece = new_piece
  end

  def move(piece, coord)

    if (piece.is_a?(Pawn))
      if (en_passant?(piece, coord))
        give_en_passant(piece, coord)
      elsif (coord == piece.en_passant_capture)
        capture_en_passant(piece, coord)
      end
    end

    if (piece.is_a?(King))
      if (!castle_moves(piece).empty?)
        if (coord == [0, 2])
          rook = get_corner_piece(piece.color, -1)
          move(rook, [coord[0], coord[1] + 1])
        elsif (coord == [0, 6])
          rook = get_corner_piece(piece.color, 1)
          move(rook, [coord[0], coord[1] - 1])
        end
      end
    end

    piece.has_moved = true
    remove_en_passant(piece.color)

    change_position(piece, coord)
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

  def get_valid_moves(piece)
    init_pos = [piece.position[0], piece.position[1]]
    valid_moves = piece.get_possible_moves(self)
    return valid_moves if valid_moves.empty?

    #check if one of the moves exposes check
    i = 0
    while (i < valid_moves.length)
      m = valid_moves[i]
      captured_piece = change_position(piece, m)
      if (king_in_check?(piece.color))
        valid_moves.delete(m)
        i -= 1
      end
      if (captured_piece)
        get_square(m).piece = captured_piece
      else
        get_square(m).piece = nil
      end
      piece.update_position(init_pos)
      i += 1
    end
    get_square(init_pos).piece = piece

    #castle moves
    if (piece.is_a?(King))
      valid_moves += castle_moves(piece)
    end
    valid_moves
  end

  def king_in_check?(color)
    king = color == :white ? @white_king : @black_king
    under_attack?(color, king.position)
  end

  def castle_moves(king)
    moves = []
    row = king.position[0]
    if (can_castle?(king, 1))
      col = king.color == :white ? 6 : 1
      moves << [row, col]
    end
    if (can_castle?(king, -1))
      col = king.color == :white ? 2 : 5
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
    rook_square = get_square([row, col])
    
    return false if (rook_square == nil)
    return false if (rook_square.piece == nil)
    return false if (rook_square.piece.has_moved)

    moves = king.linear_moves(king, [0, dir], x_offset - 1)

    moves.each do |m|
      if (!free?(m))
        return false
      end

      break if (dir == -1 && m == moves.last)

      if (under_attack?(king.color, m))
        return false
      end
    end
    return true
  end

  def get_corner_piece(color, side)
    row = color == :white ? 0 : 7
    if (color == :white)
      col = side == 1 ? 7 : 0
    else
      col = side == 1 ? 0 : 7
    end
    get_square([row, col]).piece
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

  def checkmate?(color)
    return false if (!king_in_check?(color))
    stalemate?(color)
  end

  def stalemate?(color)
    pieces = @data.flatten.map { |sq| sq.piece}
    pieces.compact!.filter! { |p| p.color == color}
    pieces.each do |piece|
      return false if !get_valid_moves(piece).empty?
    end
    return true
  end

end
