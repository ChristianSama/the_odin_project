require_relative 'board'

class Chess
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
  end
  
  def start
    while(true)

      system "cls"
      selection = nil
      valid_moves = nil
      
      @board.print_board

      if (@board.checkmate?(@current_player))
        puts "Checkmate - #{@current_player == :white ? :black : :white} player won"
        break
      elsif(@board.stalemate?(@current_player))
        puts "Stalemate - #{@current_player} has no valid moves"
        break
      end

      #selection phase

      puts "#{@current_player}'s turn."
      puts 'Input the coordinates of a piece to select it for example: D2.'
      loop do
        input = gets.chomp
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
      @board.print_board
      puts 'Input the coordinates of a square to move.'
      loop do
        input = gets.chomp
        if (!valid_coordinate?(input))
          puts 'Invalid coordinate. Try again.'
          next
        elsif (!valid_moves.include?(translate(input)))
          puts 'Invalid move. Try again.'
          next
        end
        @board.move(@board.selected_piece, translate(input))
        @board.unmark_moves

        if (@board.pawn_last_rank?(@board.selected_piece))

          piece = nil
          loop do
            puts 'Choose a piece to promote your pawn: ' +
                '\n1: Queen' +
                '\n2: Rook' +
                '\n3: Bishop' +
                '\n4: Knight'
            input = gets.chomp.to_i
            
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

            break if (input < 5 || input > 0)
          end
          
          @board.promote_pawn(@board.selected_piece, piece)
        end

        break
      end
      
      @current_player = @current_player == :white ? :black : :white

    end
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
end

game = Chess.new
game.start