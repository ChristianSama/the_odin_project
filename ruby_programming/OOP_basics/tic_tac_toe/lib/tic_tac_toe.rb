def print_board(board)
  puts " #{board[0][0]} | #{board[0][1]} | #{board[0][2]} 
 #{board[1][0]} | #{board[1][1]} | #{board[1][2]} 
 #{board[2][0]} | #{board[2][1]} | #{board[2][2]} "
end

class Player
  attr_accessor :number

  @@total_players = 0

  def initialize
    @@total_players += 1
    @number = @@total_players
  end
  
  def play_turn
    puts "Player#{@number} enter a position of the board"
    loop do
      position = gets.to_i
      if $board.flatten.include?(position)
        case position
        when 1
          $board[0][0] = @number == 1 ? 'X' : 'O'
        when 2
          $board[0][1] = @number == 1 ? 'X' : 'O'
        when 3
          $board[0][2] = @number == 1 ? 'X' : 'O'
        when 4
          $board[1][0] = @number == 1 ? 'X' : 'O'
        when 5
          $board[1][1] = @number == 1 ? 'X' : 'O'
        when 6
          $board[1][2] = @number == 1 ? 'X' : 'O'
        when 7
          $board[2][0] = @number == 1 ? 'X' : 'O'
        when 8
          $board[2][1] = @number == 1 ? 'X' : 'O'
        when 9
          $board[2][2] = @number == 1 ? 'X' : 'O'
        end
        break
      else
        puts "Position not available, try another one!"
      end
    end
  end  
end

def tic_tac_toe
  
  $board = [[1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]]

  player1 = Player.new()
  player2 = Player.new()
  print_board($board)
  
  for i in 1..9
    i.odd? ? player1.play_turn : player2.play_turn
    if ($board[0][0] == $board[0][1] && $board[0][1] == $board[0][2]) && i < 9
      puts $board[0][0] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif ($board[1][0] == $board[1][1] && $board[1][1] == $board[1][2]) && i < 9
      puts $board[1][0] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif ($board[2][0] == $board[2][1] && $board[2][1] == $board[2][2]) && i < 9
      puts $board[2][0] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif ($board[0][0] == $board[1][0] && $board[1][0] == $board[2][0]) && i < 9
      puts $board[0][0] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif ($board[0][1] == $board[1][1] && $board[1][1] == $board[2][1]) && i < 9
      puts $board[0][1] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif ($board[0][2] == $board[1][2] && $board[1][2] == $board[2][2]) && i < 9
      puts $board[0][2] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif ($board[0][0] == $board[1][1] && $board[1][1] == $board[2][2]) && i < 9
      puts $board[0][0] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif ($board[0][2] == $board[1][1] && $board[0][1] == $board[2][0]) && i < 9
      puts $board[0][2] == "X" ? "Player1 wins!" : "Player 2 wins!"
      return
    elsif i >= 9
      puts "tie"
      return
    end
    print_board($board)
  end
end

tic_tac_toe

