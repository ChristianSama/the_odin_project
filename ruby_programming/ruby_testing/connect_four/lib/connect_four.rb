class Cell
  attr_accessor :token
  def initialize
    @free = true
    @token = " "
  end

  def fill
    @token = "☻" #☺
  end
end

class Board
  attr_reader :board
  def initialize(cols, rows)
    @cols = cols
    @rows = rows
    @board = []
  end

  def create_board
    @rows.times do
      #@board.push(Array.new(@cols, Cell.new))
      row = []
      @cols.times do
        row << Cell.new
      end
      @board << row
    end
  end

  def print_board
    @board.each do |row|
      @cols.times do |i|
        print "----"
        if (i+1 == @cols)
          print "-"
        end
      end
      print "\n"
      row.each do |el|
        print "| #{el.token} "
        if (row.last == el)
          print "|\n"
        end
      end
      if (@board.last == row)
        @cols.times do |i|
          print "----"
          if (i+1 == @cols)
            print "-"
          end
        end
        print "\n"
      end
    end
    puts '  0   1   2   3   4   5   6'
  end
end

class Player
  def play_turn(board)
    puts "enter the number corresponding a column"
    col = gets.chomp.to_i

    for row in 0...board.length
      cur = board[col][row].token
    end
  end
end

class Game

end

# circle = "⚫"
# puts circle

b = Board.new(7, 6)
b.create_board
b.print_board
#p b.board
#b.print_board
#p = Player.new
#p.play_turn(b.board)
#b.board[3][1].token = '⚫'
#b.print_board
