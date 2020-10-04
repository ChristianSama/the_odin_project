class Board
  attr_accessor :cols, :rows
  
  def initialize 
    @cols = 8
    @rows = 8
  end
end

class Pos
  attr_accessor :pos, :possible_moves, :dist, :prev
  def initialize(pos)
    @pos = pos
    @possible_moves = []
    @dist = 0
    @prev = nil
  end
end

class Knight
  attr_accessor :cur_pos
  def initialize(pos)
    @cur_pos = Pos.new(pos)
  end

  def get_possible_moves(pos)
    possible_moves = []

    x_move = -2
    y_move = -2

    while x_move <= 2
      if (x_move == 0)
        x_move += 1
        next
      end
      y_move = -2
      x = pos[0] + x_move
      if (x < 1 || x > 8)
        x_move += 1
        next
      end
      while y_move <= 2
        if (x_move.abs == y_move.abs || y_move == 0)
          y_move += 1
          next
        end
        y = pos[1] + y_move
        if (y > 8 || y < 1)
          y_move += 1
          next
        end
        possible_moves.push(Pos.new([x, y]))
        y_move += 1
      end
      x_move += 1
    end
    possible_moves
  end

  # def build(pos, target, visited = [])
  #   root = Pos.new(pos)
  #   if (visited.empty?) 
  #     visited << pos
  #   end
  #   get_possible_moves(pos).each do |el|
  #     if (el == target)
  #       visited << el
  #       return root
  #     end
  #     p visited
  #     p el
  #     if (visited.include?(el) == false)
  #       visited << el
  #       root.possible_moves << build(el, target, visited)
  #     end
  #   end
  #   return root
  # end

  def knight_moves(start, dest)
    cur = Pos.new(start)
    visited = []
    previous = []
    q = []
    path = []

    q << cur
    visited << cur

    while (!q.empty?)
      u = q.shift
      if (u.pos == dest)
        #return u
        while (u != nil)
          path << u.pos
          u = u.prev
        end
        return path.reverse
      end
      
      get_possible_moves(u.pos).each do |neighbour|
        if (!visited.include?(neighbour))
          previous << neighbour
          neighbour.prev = u
          neighbour.dist += 1
          q << neighbour
          visited << neighbour
        end
      end
    end
    return 'destination is not reachable'
  end



end

b = Board.new()
k = Knight.new([1,1])

p k.knight_moves([4,4], [1,1])
