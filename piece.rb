
class Piece
  
  attr_reader :position, :color
  
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end
  
  def move_diffs
    row, col = @position
    diff = green? ? -1 : 1
    {
      :slide => 
                [[row + diff, col - 1],
                [row + diff, col + 1]],
                
      :jump =>  [[row + (diff * 2), col - 1],
                [row + (diff * 2), col + 1]]
    }
  end
  
  def valid_moves
    differences = move_diffs
    valids = []
    
    left_slide = differences[:slide].first
    right_slide = differences[:slide].last
    
    left_jump = differences[:jump].first
    right_jump = differences[:jump].last
    
    if @board[left_slide].empty? 
      valids << left_slide
    elsif @board[left_jump].empty? && has_enemy?(left_slide)
      valid_moves << right_jump
    end
    
    if @board[right_slide].empty?
      valids << right_slide
    elsif @board[right_jump].empty? && has_enemy?(right_slide)
      valids << right_jump
    end
    
    valids
    
  end
  
  def has_enemy?(pos)
    tile = @board[pos]
    
    tile.occupied? && enemy?(tile.piece) 
  end
  
  def enemy?(piece)
    piece.color != @color
  end
  
  def valid?(target)
    valid_moves.include? target
  end
  
  def perform_jump(target)
    return false unless valid?(target)
    
    @position = target
    true
  end
  
  def perform_slide(target)
    return false unless valid?(target)
    
    @position = target
    true
  end
  
  def green?
    @color == :green
  end
  
  def orange?
    !green?
  end
  
  def move(target)
    perform_slide(target) || perform_jump(target)
  end
  
end