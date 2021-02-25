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

  def setup_black_pieces
    row = 7
    @data[0][row] = Rook.new(:black, 0, row)
    @data[1][row] = Knight.new(:black, 1, row)
    @data[2][row] = Bishop.new(:black, 2, row)
    @data[3][row] = Queen.new(:black, 3, row)
    @data[4][row] = King.new(:black, 4, row)
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
    @data[3][row] = King.new(:white, 3, row)
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
    return nil if (coord.empty?) #Creo que se puede remover
    return nil if (coord[0] >= @data.length || coord[1] >= @data.length)
    piece = data[coord[0]][coord[1]]
    return nil if (piece == '.')
    return piece
  end

  def set_piece(coord, obj)#[3,2]
    data[coord[0]][coord[1]] = obj
  end

end