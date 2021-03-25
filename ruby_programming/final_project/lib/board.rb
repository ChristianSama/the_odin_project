project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  attr_reader :data, :white_king, :black_king

  def initialize
    @data = Array.new(8) {Array.new(8)}
    setup_board #detras de escenas se maneja la matriz original (no transpuesta)
  end

  def setup_board 
    setup_black_pieces
    setup_white_pieces
  end

  def setup_black_pieces #podria usar set_piece
    row = 7
    @data[0][row] = Rook.new(:black, 0, row)
    @data[1][row] = Knight.new(:black, 1, row)
    @data[2][row] = Bishop.new(:black, 2, row)
    @data[3][row] = Queen.new(:black, 3, row)
    @black_king = King.new(:black, 4, row)
    @data[4][row] = @black_king
    @data[5][row] = Bishop.new(:black, 5, row)
    @data[6][row] = Knight.new(:black, 6, row)
    @data[7][row] = Rook.new(:black, 7, row)
    #pawn setup
    @data.each_with_index { |e, i| @data[i][6] = Pawn.new(:black, i, 6)}
    
  end

  def setup_white_pieces
    row = 0
    @data[0][row] = Rook.new(:white, 0, row)
    @data[1][row] = Knight.new(:white, 1, row)
    @data[2][row] = Bishop.new(:white, 2, row)
    @white_king = King.new(:white, 3, row)
    @data[3][row] = @white_king
    @data[4][row] = Queen.new(:white, 4, row)
    @data[5][row] = Bishop.new(:white, 5, row)
    @data[6][row] = Knight.new(:white, 6, row)
    @data[7][row] = Rook.new(:white, 7, row)
    #pawn setup
    @data.each_with_index { |e, i| @data[i][1] = Pawn.new(:white, i, 1)}
  end

  def print_board
    (@data.size - 1).downto(0) do |i|
      #print divider
      print '   '
      8.times {print '+---'}
      puts '+'
      #print row
      print " #{i} "
      @data.transpose[i].each_with_index do |e, i| #Se muestra transpuesta
        e == nil ? (print '|   ') : (print "| #{e} ")
      end
      puts '|'
    end
    #print bottom divider
    print '   '
    8.times {print '+---'}
    puts '+'
    #print bottom legend
    puts '     0   1   2   3   4   5   6   7'
  end

  def get_piece(coord)
    coord.each do |e|
      return nil if (e > 7 || e < 0)
    end
    piece = data[coord[0]][coord[1]]
    return nil if (piece == '.')
    return piece
  end

  def set_piece(coord, obj)#[3,2]
    data[coord[0]][coord[1]] = obj
    if(obj.is_a?(Piece))
      obj.x = coord[0]
      obj.y = coord[1]
    end
  end

  def change_location(piece, coord)
    
    prev_coord = [piece.x, piece.y]

    set_piece(coord, piece)
    set_piece(prev_coord, nil)

    if (king_in_check?(piece.color))
      set_piece(prev_coord, piece)
      set_piece(coord, nil)
    else
      piece.has_moved = true
    end
  end

  def auto_check?(piece, coord)
    prev_coord = [piece.x, piece.y]

    change_location(piece, coord)

    if (king_in_check?(piece.color))
      change_location(piece, prev_coord)
      return false
    end

    return true
  end

  def king_in_check?(color)
    king = color == :white ? @white_king : @black_king
    pieces = @data.flatten.compact
    pieces.any? do |piece|
      next if piece.color == color
      piece.get_possible_moves(self).include?([king.x, king.y])
    end
  end

end