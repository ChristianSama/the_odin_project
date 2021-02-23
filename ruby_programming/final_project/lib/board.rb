project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  attr_reader :data

  def initialize
    @data = Array.new(8) {Array.new(8)}
    setup_board
  end

  def setup_board #detras de escenas se maneja la matriz original (no transpuesta)
    @data[0][7] = Rook.new(:black)
    @data[1][7] = Knight.new(:black)
    @data[2][7] = Bishop.new(:black)
    @data[3][7] = Queen.new(:black)
    @data[4][7] = King.new(:black)
    @data[5][7] = Bishop.new(:black)
    @data[6][7] = Knight.new(:black)
    @data[7][7] = Rook.new(:black)
    @data.each_with_index { |e, i| @data[i][6] = Pawn.new(0, i, 6)}
    @data[4][3] =  Pawn.new(:black, 3, 3)

    @data[0][0] = Rook.new(:white)
    @data[1][0] = Knight.new(:white)
    @data[2][0] = Bishop.new(:white)
    @data[3][0] = King.new(:white)
    @data[4][0] = Queen.new(:white)
    @data[5][0] = Bishop.new(:white)
    @data[6][0] = Knight.new(:white)
    @data[7][0] = Rook.new(:white)
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