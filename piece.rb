require "./movement.rb"


class Piece
  include Movement
    
  attr_reader :position, :color, :jumped
  
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    @jumped = Hash.new
    @deltas = move_diffs
    @king = false
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
  
  def promoted?
    if green?
      true if @position[0] == 0
    else
      true if @position[0] == 7
    end
    false
  end
  
  def king_me
    @king = true
  end
 
end