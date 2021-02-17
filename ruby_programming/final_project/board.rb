project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  attr_reader :data

  def initialize
    @data = Array.new(8) {Array.new(8)}
    fill_board
  end

  def fill_board #detras de escenas se maneja la matriz original (no transpuesta)
    @data[0][7] = Rook.new('b')
    @data[1][7] = Knight.new('b')
    @data[2][7] = Bishop.new('b')
    @data[3][7] = Queen.new('b')
    @data[4][7] = King.new('b')
    @data[5][7] = Bishop.new('b')
    @data[6][7] = Knight.new('b')
    @data[7][7] = Rook.new('b')
    @data.each_with_index { |e, i| @data[i][6] = Pawn.new('b', i, 6)}

    @data[0][0] = Rook.new('w')
    @data[1][0] = Knight.new('w')
    @data[2][0] = Bishop.new('w')
    @data[3][0] = King.new('w')
    @data[4][0] = Queen.new('w')
    @data[5][0] = Bishop.new('w')
    @data[6][0] = Knight.new('w')
    @data[7][0] = Rook.new('w')
    @data.each_with_index { |e, i| @data[i][1] = Pawn.new('w', i, 1)}
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
        e == nil ? (print '|   ') : (print "| #{e.sprite} ")
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
end