class Cell
  attr_accessor :token, :isFree
  def initialize
    @isFree = true
    @token = " "
  end

  def fill(mark)
    @token = mark #☺
    @isFree = false
  end
end

class Board
  attr_reader :board, :cols, :rows
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
      #imprimir separadores 
      @cols.times do |i|
        print "----"
        if (i+1 == @cols)
          print "-"
        end
      end
      print "\n"
      #imprimir barras y tokens
      row.each do |el|
        print "| #{el.token} "
        if (row.last == el)
          print "|\n"
        end
      end
      #imprimir ultimo separador
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

  def initialize(mark)
    @mark = mark
  end

  def play_turn(b)
    col = nil
    loop do
      puts "enter the number corresponding a column"
      col = gets.chomp.to_i
      break if (col < b.cols && col >= 0)
    end
    for row in 0...b.board.length do
      next_cell = b.board[row][col]
      if (row == 0 && next_cell.isFree == false)
        puts "Move not valid, try another column"
        return
      elsif (next_cell.isFree)
        cur_cell = next_cell
      end
    end
    cur_cell.fill(@mark)
  end
end

class Game
  @winner = nil

  def start
    turn = 0

    b = Board.new(7, 6)
    b.create_board
    b.print_board

    p1 = Player.new("☻")
    p2 = Player.new("☺")

    while (@winner == nil && turn < b.cols * b.rows) do #test max turn
      if (turn % 2 == 0)
        play = p2.play_turn(b)
      else
        play = p1.play_turn(b)
      end
      if (play != nil)
        b.print_board
        turn += 1
        puts turn
      end
    end
  end

  def check_win
    
  end
end

g = Game.new
g.start



