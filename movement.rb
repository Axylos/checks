module Movement
  
  def move_diffs
    row, col = @position
    diff = green? ? -1 : 1
    
      moves = {

                          :left => { 
                            :slide => [row + diff, col - 1],
                            :jump =>  [row + (diff * 2), col - 2]
                          },

                          :right => {
                            :slide => [row + diff, col + 1],
                            :jump => [row + (diff * 2), col + 2]
                          }

    }
    
    if @king
     
     moves[:king_left] = { 
                              :slide => [row - diff, col - 1],
                              :jump => [row - (diff * 2), col - 2]
                          }
      
     moves[:king_right] = {
                              :slide => [row - diff, col + 1],
                              :jump => [row - (diff * 2), col + 2]
                          }
    end
    moves
  end
  
  def valid_moves
    differences = move_diffs
    valids = Hash.new { |h,k| h[k] = [] }
    
    
    differences.each do |dir, movements|
      slide = movements[:slide]
      jump = movements[:jump]
      
      
      if @board[slide].empty? 
        valids[:slides] << slide
      
      elsif has_enemy?(slide)
        @jumped[:left] = [@board[slide].piece, jump]
        valids[:jumps] << jump
      
      end
    
    end
    
    
    valids
  end
 
  def valid_jump?(target)
    valids = valid_moves
    valids[:jumps].include?(target)
  end
  
  def valid_slide?(target)
    valids = valid_moves
    
    valids[:slides].include?(target)
  end
  
  def perform_slide(target)
    return false unless valid_slide?(target)
    
    @position = target
    true
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
  
  def move(target)
    return false unless perform_slide(target) || perform_jump(target)
    king_me if promoted?
    true
  end
  
end