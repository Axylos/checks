require 'debugger'

class Board
  include GenerateBoard
  include DisplayBoard
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    make_board
    make_starting_pieces
  end
  
  def move_piece(piece, target)
    self[piece.position].remove_piece
    self[target].add_piece piece
  end
  
  def move(start_pos, end_pos)
    start_tile = self[start_pos]
    end_tile = self[end_pos]
    
    piece = start_tile.piece
    
    if piece.move(end_pos)
      start_tile.remove_piece
      end_tile.add_piece piece
      
    else
      "You can't move there!"
      return false
    end
    true
  end
  
  def remove_piece(piece)
    pos = piece.position
    self[pos].remove_piece
  end
  
end