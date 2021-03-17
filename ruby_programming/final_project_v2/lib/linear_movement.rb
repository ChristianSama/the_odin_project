module Linear_movement

  def linear_moves(piece, axis, num_squares = nil) #king, [1, 0], 1
    moves = []
    move = piece.position
    num_squares = 8 if (num_squares == nil)
    while (moves.length <= num_squares)
      move = [move[0] + (axis[0] * piece.direction), move[1] + (axis[1] * piece.direction)]
      break if (!inside_board?(move))
      moves << move
    end
    moves
  end

  def inside_board?(coord)
    if (coord[0] < 0 || coord[0] > 7 ||
        coord[1] < 0 || coord[1] > 7)
      return false
    end
    return true
  end
end