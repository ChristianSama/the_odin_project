class Cell
  attr_accessor :token, :isFree, :index
  

  def initialize(index)
    @index = index
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
    i = 1
    @rows.times do
      #@board.push(Array.new(@cols, Cell.new))
      row = []
      @cols.times do
        row << Cell.new(i)
        i += 1
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
  #@win_lines = 

  def start
    turn = 0

    b = Board.new(7, 6)
    b.create_board
    b.print_board

    p1 = Player.new("☻")
    p2 = Player.new("☺")

    # while (@winner == nil && turn < b.cols * b.rows) do #test max turn
    #   if (turn % 2 == 0)
    #     play = p2.play_turn(b)
    #   else
    #     play = p1.play_turn(b)
    #   end
    #   if (play != nil)
    #     b.print_board
    #     turn += 1
    #     puts turn
    #   end
    # end
    b.board[0][0].token = 'o'
    b.board[0][1].token = 'x'
    b.board[0][2].token = ' '
    b.board[0][3].token = 'x'
    b.board[0][4].token = 'x'
    b.board[0][5].token = 'o'
    b.board[0][6].token = 'x'
    b.board[1][0].token = 'o'
    b.board[1][1].token = 'o'
    b.board[1][2].token = 'o'
    b.board[1][3].token = 'o'
    b.board[1][4].token = 'x'
    b.board[1][5].token = 'o'
    b.board[1][6].token = 'x'
    b.print_board
    check_win(b.board)
  end

  def check_win(board)
    #check horizontal lines
    # board.each do |row|
    #   count = 0
    #   for i in (0...row.size - 1)
    #     if ((row[i].token == ' ') || (row[i].token != row[i+1].token))
    #       count = 0
    #       next
    #     else
    #       count += 1
    #       if (count >= 3)
    #         puts 'true'
    #         return true
    #       end
    #     end
    #   end
    # end
    
    #check vertical lines
    (0...board[0].size).each do |i|
      
    end
  end
end

g = Game.new
g.start




