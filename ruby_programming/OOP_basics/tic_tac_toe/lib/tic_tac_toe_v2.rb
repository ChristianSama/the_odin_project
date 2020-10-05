class Board
  attr_accessor :board
  def initialize
    @board = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]
  end
  def print_board
    puts "#{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    puts "#{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    puts "#{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
  end
end

class Player
  attr_accessor :id
  @@total_players = 0

  def initialize
    @@total_players += 1
    @id = @@total_players
  end

  def play_turn(board)
    puts "Player#{@id} enter a position of the board"
    loop do
      position = gets.to_i
      if board.flatten.include?(position)
        case position
        when 1
          board[0][0] = @id == 1 ? 'X' : 'O'
        when 2
          board[0][1] = @id == 1 ? 'X' : 'O'
        when 3
          board[0][2] = @id == 1 ? 'X' : 'O'
        when 4
          board[1][0] = @id == 1 ? 'X' : 'O'
        when 5
          board[1][1] = @id == 1 ? 'X' : 'O'
        when 6
          board[1][2] = @id == 1 ? 'X' : 'O'
        when 7
          board[2][0] = @id == 1 ? 'X' : 'O'
        when 8
          board[2][1] = @id == 1 ? 'X' : 'O'
        when 9
          board[2][2] = @id == 1 ? 'X' : 'O'
        end
        break
      else
        puts "Position not available, try another one!"
      end
    end
  end
end

class Game

  def initialize
    @board = Board.new
    @p1 = Player.new
    @p2 = Player.new
    @turn = 1
    @winner = nil
  end

  def start
    @board.print_board
    while @turn <= 9 && @winner == nil
      @turn.odd? ? @p1.play_turn(@board.board) : @p2.play_turn(@board.board)
      @board.print_board
      check_win
      @turn += 1
    end
  end

  def check_win
    if (@board.board[0][0] == @board.board[0][1] && @board.board[0][1] == @board.board[0][2]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif (@board.board[1][0] == @board.board[1][1] && @board.board[1][1] == @board.board[1][2]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif (@board.board[2][0] == @board.board[2][1] && @board.board[2][1] == @board.board[2][2]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif (@board.board[0][0] == @board.board[1][0] && @board.board[1][0] == @board.board[2][0]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif (@board.board[0][1] == @board.board[1][1] && @board.board[1][1] == @board.board[2][1]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif (@board.board[0][2] == @board.board[1][2] && @board.board[1][2] == @board.board[2][2]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif (@board.board[0][0] == @board.board[1][1] && @board.board[1][1] == @board.board[2][2]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif (@board.board[0][2] == @board.board[1][1] && @board.board[0][1] == @board.board[2][0]) && @turn < 9
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif @turn == 9
      puts "tie"
    end
  end

  def game_over(winner)
    puts "Player #{winner.id} is the winner!"
  end
end

g = Game.new
g.start