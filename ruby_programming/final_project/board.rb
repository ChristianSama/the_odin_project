project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pieces/*') {|file| require file}

class Board
  attr_reader :data

  def initialize()
    @data = Array.new(8) {Array.new(8)}
  end

  def fill_board
    #White Pieces
    @data[-1][0] = Rook.new('w')
    @data[-1][1] = Knight.new('w')
    @data[-1][2] = Bishop.new('w')
    @data[-1][3] = Queen.new('w')
    @data[-1][4] = King.new('w')
    @data[-1][5] = Bishop.new('w')
    @data[-1][6] = Knight.new('w')
    @data[-1][7] = Rook.new('w')
    @data[-2].each_with_index { |e, i| @data[-2][i] = Pawn.new('w')}

    #Black Pieces
    @data[0][0] = Rook.new('b')
    @data[0][1] = Knight.new('b')
    @data[0][2] = Bishop.new('b')
    @data[0][3] = King.new('b')
    @data[0][4] = Queen.new('b')
    @data[0][5] = Bishop.new('b')
    @data[0][6] = Knight.new('b')
    @data[0][7] = Rook.new('b')
    @data[1][0] = Pawn.new('b')
    @data[1].each_with_index { |e, i| @data[1][i] = Pawn.new('b')}
  end

  def print_board
    @data.each do |row|
      #print divider
      8.times {print '+---'}
      puts '+'
      #print row
      row.each do |e|
        e == nil ? (print '|   ') : (print "| #{e.sprite} ")
      end
      puts '|'
    end
    #print bottom divider
    8.times {print '+---'}
    puts '+'
  end
end