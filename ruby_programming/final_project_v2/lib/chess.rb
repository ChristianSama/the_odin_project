require_relative 'board'

class Chess
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
  end
  
  def start
    loop do
      catch :game_loop do 
        selection = nil
        valid_moves = nil
        
        system "clear"
        @board.unmark_moves
        @board.print_board
        break if game_over?
        #selection phase
  
        loop do
          input = ask_input("#{@current_player}'s turn.\nInput the coordinates of a piece to select it. 'exit' to terminate")
          return if input == 'exit'
  
          if (!valid_coordinate?(input))
            puts 'Invalid coordinate. Try again.'
            next
          elsif (!valid_selection?(translate(input)))
            puts 'Invalid selection. Try selecting one of your pieces.'
            next
          end
          selection = @board.select_piece(translate(input))
          valid_moves = @board.get_valid_moves(selection)
  
          if (valid_moves.empty?)
            puts 'Selected piece has no valid moves. Try again.'
            next
          end
          @board.mark_moves(valid_moves)
          break
        end
        
        #move phase
        system "clear"
        @board.print_board
        
        loop do
          input = ask_input("Input the coordinates of a square to move.\n'exit' to terminate\n'cancel' to cancel move")
          return if input == 'exit'
          throw :game_loop if input == 'cancel'
            
          if (!valid_coordinate?(input))
            puts 'Invalid coordinate. Try again.'
            next
          elsif (!valid_moves.include?(translate(input)))
            puts 'Invalid move. Try again.'
            next
          end
          @board.move(@board.selected_piece, translate(input))
  
          if (@board.pawn_last_rank?(@board.selected_piece))
  
            piece = nil
            loop do
              puts 
              input = ask_input("Choose a piece to promote your pawn: \n1: Queen\n2: Rook\n3: Bishop\n4: Knight")
              input = input.to_i
              piece = choose_promotion(input)
              break if (input < 5 || input > 0)
            end
            @board.promote_pawn(@board.selected_piece, piece)
          end
          break
        end
        @current_player = @current_player == :white ? :black : :white
      end
    end
  end

  def game_over?
    if (@board.checkmate?(@current_player))
      puts "Checkmate - #{@current_player == :white ? :black : :white} player won"
      return true
    elsif(@board.stalemate?(@current_player))
      puts "Stalemate - #{@current_player} has no valid moves"
      return true
    end
    return false
  end

  def choose_promotion(input)
    piece = nil
    case input
    when 1
      piece = Queen.new(@current_player)
    when 2
      piece = Rook.new(@current_player)
    when 3
      piece = Bishop.new(@current_player)
    when 4
      piece = Knight.new(@current_player)
    else
      puts 'Invalid selection. Enter a number 1 - 4'
    end
    piece
  end

  def valid_coordinate?(alg_notation)
    return true if alg_notation.match?(/^[a-h][1-8]$/i)
    return false
  end

  def valid_selection?(coord)
    piece = @board.get_square(coord).piece
    return false if (piece == nil || piece.color != @current_player)
    return true
  end

  def translate(alg_notation)
    coord = alg_notation.split("")
    temp = coord[0] #a
    coord[0] = coord[1].to_i - 1
    coord[1] = temp.downcase.ord - ('a'.ord)
    return coord
  end

  def ask_input(prompt)
    puts prompt
    input = gets.chomp
    input
  end
end

game = Chess.new
game.start