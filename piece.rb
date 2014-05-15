
class Piece
  
  attr_reader :position, :color, :jumped
  
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    @jumped = Hash.new
  end
  
  
  
  def die
    @position = nil
  end
  
  
  
  def has_enemy?(pos)
    tile = @board[pos]
    
    enemy?(tile.piece) 
  end
  
  def enemy?(piece)
    piece.color != @color
  end
  
  
  
  def kill_piece(piece)
    @board.remove_piece(piece)
    piece.die
  end
  
  
  
  def green?
    @color == :green
  end
  
  def orange?
    !green?
  end
  
  
  
end