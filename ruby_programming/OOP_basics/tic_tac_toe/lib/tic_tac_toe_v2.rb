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

  def initialize(id)
    @id = id
  end

  def play_turn(board)
    marker = @id == 1 ? 'X' : 'O'
    puts "Player#{@id} enter a position of the board"
    loop do
      position = gets.to_i
      if board.flatten.include?(position)
        case position
        when 1
          board[0][0] = marker
        when 2
          board[0][1] = marker
        when 3
          board[0][2] = marker
        when 4
          board[1][0] = marker
        when 5
          board[1][1] = marker
        when 6
          board[1][2] = marker
        when 7
          board[2][0] = marker
        when 8
          board[2][1] = marker
        when 9
          board[2][2] = marker
        end
        break
      else
        puts "Position not available, try another one!"
      end
    end
    marker
  end
end

class Game
  attr_accessor :board, :winner, :p1

  def initialize
    @board = Board.new
    @p1 = Player.new(1)
    @p2 = Player.new(2)
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
    if ((@board.board[0][0] == @board.board[0][1] && @board.board[0][1] == @board.board[0][2]) ||
        (@board.board[1][0] == @board.board[1][1] && @board.board[1][1] == @board.board[1][2]) ||
        (@board.board[2][0] == @board.board[2][1] && @board.board[2][1] == @board.board[2][2]) ||
        (@board.board[0][0] == @board.board[1][0] && @board.board[1][0] == @board.board[2][0]) ||
        (@board.board[0][1] == @board.board[1][1] && @board.board[1][1] == @board.board[2][1]) ||
        (@board.board[0][2] == @board.board[1][2] && @board.board[1][2] == @board.board[2][2]) ||
        (@board.board[0][0] == @board.board[1][1] && @board.board[1][1] == @board.board[2][2]) ||
        (@board.board[0][2] == @board.board[1][1] && @board.board[0][1] == @board.board[2][0]))
      @winner = @turn.odd? ? @p1 : @p2
      game_over(@winner)
    elsif @turn == 9
      game_over(@winner)
    end
  end

  def game_over(winner)
    if (winner != nil)
      puts "Player #{winner.id} is the winner!"
    else
      puts "tie"
    end
    return true
  end

end

# g = Game.new
# g.start