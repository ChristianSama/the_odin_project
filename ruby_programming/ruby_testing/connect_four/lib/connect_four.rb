class Cell
  attr_accessor :token
  def initialize
    @free = true
    @token = 1
  end

  def fill
    @token = "⚫"
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
      @board.push(Array.new(@cols, Cell.new))
    end
  end

  def print_board
    i = 0
    @board.each do |row|
      row.each do |el|
        el.token = i
        print "#{el.token} "
        i += 1
      end
      print "\n"
    end
    puts '0 1 2 3 4 5 6'
  end
end

class Player

  def play_turn(board)
    puts "enter the number corresponding a column"
    col = gets.chomp.to_i

    for row in 0...board.length
      p cur = board[col][row].token
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
puts "----------"
p b.board
#b.print_board
# p = Player.new
# p.play_turn(b.board)
