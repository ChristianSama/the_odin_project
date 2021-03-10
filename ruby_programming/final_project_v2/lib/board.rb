require_relative 'square'
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  
  attr_reader :data, :selected_piece

  def initialize
    @data = Array.new(8) {Array.new(8) {Square.new}}
    setup_pieces(:white)
    setup_pieces(:black)
    @data[3][3].piece = Bishop.new(:white, [3, 3])
  end

  def setup_pieces(color)
    # row = color == :white ? 0 : 7
    # @data[row][0].piece = Rook.new(color)
    # @data[row][1].piece = Knight.new(color)
    # @data[3][3].piece = Bishop.new(color, [3, 3])
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
      row.each do |square|
        if (square.piece == nil)
          if (square.marked)
            print "| #{square.mark} "
            next
          end
          print "|   "
        else
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
    @selected_piece = @data[coord[0]][coord[1]].piece
    #mark_move_set
  end

  def get_square(coord)
    return @data[coord[0]][coord[1]]
  end

  # def mark_move_set
  #   @selected_piece.move_set.each do |coord|
  #     if (inside_board?(coord))
  #       square = @data[coord[0]][coord[1]]
  #       square.marked = true if square.piece == nil
  #     end
  #   end
  # end

  def inside_board?(coord)
    if (coord[0] >= 0 && coord[0] <= 8 &&
        coord[1] >= 0 && coord[1] <= 8)
      return true
    else
      return false
    end
  end

  def move(coord)
    to_square = get_square(coord)
    to_square.piece = @selected_piece
    from_square = get_square(@selected_piece.position)
    from_square.piece = nil
    @selected_piece.update_position(coord)
    @selected_piece.has_moved == true
  end

end
