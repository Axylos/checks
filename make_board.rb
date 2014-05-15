module GenerateBoard
  def make_board
    8.times do |row|
      8.times do |col|

        new_tile = Tile.new(row, col, self)
        add_tile(new_tile)
      end
    end

  end
  
  def add_tile(tile)
    self[tile.location] = tile
  end
  
  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end
  
  def make_starting_pieces
   8.times do |row|
     8.times do |col|

        pos = [row, col]
        place = self[pos]

        if place.is_black?

          if row < 3
            place.add_piece(Piece.new(:orange, pos, self)) 
          elsif row > 4
            place.add_piece(Piece.new(:green, pos, self))
          end

        end
      end
    end
    
  end

end