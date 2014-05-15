
class Piece
  
  attr_reader :position, :color, :jumped
  
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    @jumped = Hash.new
  end
  
  def move_diffs
    row, col = @position
    diff = green? ? -1 : 1
    {
      :slide => 
                [[row + diff, col - 1],
                [row + diff, col + 1]],
                
      :jump =>  [[row + (diff * 2), col - 2],
                [row + (diff * 2), col + 2]]
    }
  end
  
  def die
    @position = nil
  end
  
  def valid_moves
    differences = move_diffs
    valids = Hash.new { |h,k| h[k] = [] }
    
    left_slide = differences[:slide].first
    right_slide = differences[:slide].last
    
    left_jump = differences[:jump].first
    right_jump = differences[:jump].last
    
    if @board[left_slide].empty? 
      valids[:slides] << left_slide
      
    elsif has_enemy?(left_slide)
      
      @jumped[:left] = [@board[left_slide].piece, left_jump]
      
      valids[:jumps] << left_jump
    end
    
    if @board[right_slide].empty?
      valids[:slides] << right_slide
    
    elsif has_enemy?(right_slide)
      
      @jumped[:right] = [@board[right_slide].piece, right_jump]
      
      valids[:jumps] << right_jump
    end
    
    valids
    
  end
  
  def has_enemy?(pos)
    tile = @board[pos]
    
    enemy?(tile.piece) 
  end
  
  def enemy?(piece)
    piece.color != @color
  end
  
  def valid_jump?(target)
    valids = valid_moves
    valids[:jumps].include?(target)
  end
  
  def valid_slide?(target)
    valids = valid_moves
    
    valids[:slides].include?(target)
  end
  
  def perform_jump(target)
    return false unless valid_jump?(target)
    if target == @jumped[:left][1]
      kill_piece(@jumped[:left][0])
    else
      kill_piece(@jumped[:right][0])
    end
    
    @position = target
    
    true
  end
  
  def kill_piece(piece)
    @board.remove_piece(piece)
    piece.die
  end
  
  def perform_slide(target)
    return false unless valid_slide?(target)
    
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
   puts "what" unless perform_slide(target) || perform_jump(target)
  end
  
end