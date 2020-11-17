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
    @board = create_board
  end

  def create_board
    board = []
    i = 1
    @rows.times do
      #@board.push(Array.new(@cols, Cell.new))
      row = []
      @cols.times do
        row << Cell.new(i)
        i += 1
      end
      board << row
    end
    board
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

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def play_turn(b)
    col = nil
    loop do
      puts "enter the number corresponding a column"
      col = gets.chomp.to_i
      break if (col < b.cols && col >= 0) #TODO: validar ingreso de letras y ""
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

  def input_valid?(input)
    input.to_i.between?(0, 6)? true : false
  end
end

class Game
  @winner = nil

  def start
    turn = 0

    b = Board.new(7, 6)
    b.create_board
    b.print_board

    p1 = Player.new("Player 1", "☻")
    p2 = Player.new("Player 2", "☺")

    while (@winner == nil && turn < b.cols * b.rows) do #test max turn
      if (turn % 2 == 0)
        play = p2.play_turn(b)
        if (check_win(b.board))
          @winner = p2
          puts 'The winner is Player 2'
        end
      else
        play = p1.play_turn(b)
        if (check_win(b.board))
          @winner = p1 
          puts 'The winner is Player 1'
        end
      end
      if (play != nil)
        b.print_board
        turn += 1
      end
    end
  end

  def check_win(board)
    #check horizontal lines
    board.each do |row|
      count = 0
      for i in (0...row.size - 1)
        if ((row[i].token == ' ') || (row[i].token != row[i+1].token))
          count = 0
          next
        else
          count += 1
          if (count >= 3)
            #puts 'true horizontal'
            return true
          end
        end
      end
    end
    
    #check vertical lines TODO: implement array.transpose to check vertical lines
    3.times do |start|
      (0...board[0].size).each do |col|
        line = []
        (start..start+3).each do |row|
          line << board[row][col].token
        end
        if (line.uniq.count <= 1 && line.uniq != [' ']) #all elements in line are equal
          #puts 'true vertical'
          return true
        end
      end
    end

    #check diagonal lines
    diagonal_lines = [[[2, 0], [3, 1], [4, 2], [5, 3]], 
                     [[1, 0], [2, 1], [3, 2], [4, 3]], [[2, 1], [3, 2], [4, 3], [5, 4]], 
                     [[0, 0], [1, 1], [2, 2], [3, 3]], [[1, 1], [2, 2], [3, 3], [4, 4]], [[2, 2], [3, 3], [4, 4], [5, 5]], 
                     [[0, 1], [1, 2], [2, 3], [3, 4]], [[1, 2], [2, 3], [3, 4], [4, 5]], [[2, 3], [3, 4], [4, 5], [5, 6]],
                     [[0, 2], [1, 3], [2, 4], [3, 5]], [[1, 3], [2, 4], [3, 5], [4, 6]],
                     [[0, 3], [1, 4], [2, 5], [3, 6]]]

    diagonal_lines.each do |diagonal|
      line = []
      diagonal.each do |coor|
        row = coor[0]
        col = coor[1]
        line << board[row][col].token
      end
      #check if all elements in current line are equal
      if (line.uniq.count <= 1 && line.uniq != [' '])
        #puts 'true diagonal'
        return true
      end
    end

    return false
  end
end

g = Game.new
g.start




