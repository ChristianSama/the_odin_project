require_relative 'square'
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  
  attr_reader :data, :selected_piece

  def initialize
    @data = Array.new(8) {Array.new(8) {Square.new}}
    setup_pieces(:white)
    setup_pieces(:black)
    @data[0][4].piece = King.new(:white, [0, 4])
    @data[7][3].piece = King.new(:black, [7, 3])
  end

  def setup_pieces(color)
    row = color == :white ? 0 : 7
    # @data[row][0].piece = Rook.new(color)
    # @data[row][1].piece = Knight.new(color)
    @data[row][2].piece = Bishop.new(color, [row, 2])
    # @data[row][3].piece = Queen.new(color)
    @data[row][5].piece = Bishop.new(color, [row, 5])
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
          if (square.marked)
            print "|(#{square.piece})|"
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

  def move(coord)
    to_square = get_square(coord)
    if (to_square.piece != nil)
      @selected_piece.captured << to_square.piece
    end
    to_square.piece = @selected_piece
    from_square = get_square(@selected_piece.position)
    from_square.piece = nil
    @selected_piece.update_position(coord)
    @selected_piece.has_moved == true
  end

  def mark_possible_moves
    @selected_piece.get_possible_moves(self).each do |move|
      square = get_square(move)
      square.marked = true if square.piece == nil
    end
  end

  def unmark_possible_moves
    @selected_piece.get_possible_moves(self).each do |move|
      square = get_square(move)
      square.marked = false if square.piece == nil
    end
  end

end
