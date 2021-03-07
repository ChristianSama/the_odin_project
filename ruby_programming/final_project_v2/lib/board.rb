require_relative 'square'
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  
  attr_reader :data, :selected_piece

  def initialize
    @data = Array.new(8) {Array.new(8) {Square.new}}
    setup_pieces(:white)
    setup_pieces(:black)
  end

  def setup_pieces(color)
    # row = color == :white ? 0 : 7
    # @data[row][0].piece = Rook.new(color)
    # @data[row][1].piece = Knight.new(color)
    # @data[row][2].piece = Bishop.new(color)
    # @data[row][3].piece = Queen.new(color)
    # @data[row][4].piece = King.new(color)
    # @data[row][5].piece = Bishop.new(color)
    # @data[row][6].piece = Knight.new(color)
    # @data[row][7].piece = Rook.new(color)

    row = color == :white ? 1 : 6
    8.times do |i|
      @data[row][i].piece = Pawn.new(color, [row, i])
    end
  end

  def print_board
    @data.reverse.each_with_index do |row, i|
      #print divider
      print '   '
      8.times {print '+---'}
      puts '+'
      #print row
      print " #{8 - i} "
      row.each do |col|
        if (col.piece == nil)
          print "|   "
        else
          print "| #{col.piece} "
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
    @selected_piece = @data[coord[0]][coord[1]]
  end

  def get_square(coord)
    return @data[coord[0]][coord[1]]
  end



end
