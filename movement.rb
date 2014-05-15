module Movement
  
  def move_diffs
    row, col = @position
    moves = []
    
    diffs = deltas
    
    diffs.each do |diff_row, diff_col|
      slide = [row + diff_row, col - diff_col]
      jump = [row + (diff_row * 2), col - (diff_col * 2)]
      
      moves << [slide, jump]
    end
    
    moves
  end
  
  def valid_moves
    differences = move_diffs
    valids = Hash.new { |h,k| h[k] = [] }
    
    differences.each do |slide, jump|
      if @board[slide].empty? 
        valids[:slides] << slide
      elsif has_enemy?(slide)    
        valids[:jumps] << jump
      end
    end
    
    valids
  end
  
  def deltas
    dels = [  [1, - 1],
              [1, 1],
              [-1, -1],
              [-1, 1]
            ]
    
    if king?
      dels
    else
      orange? ? dels.first(2) : dels.last(2)
    end
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
    
    @board.move_piece(self, target)
    handle_move(target)
  end
  
  def perform_jump(target)
    return false unless valid_jump?(target)
    
    @board.move_piece(self, target)
    handle_jumped_piece(target)
    
    handle_move(target)
  end
  
  def handle_move(target)
    @position = target
    king_me if promoted?
    true
  end
  
  def move(target)
    return false unless perform_slide(target) || perform_jump(target)
    true
  end
  
  def perform_moves!(move_sequence)
    many = move_sequence.count > 1
    
    move_sequence.each do |move|
      if perform_slide move
        raise InvalidMoveError if many
        true
      elsif perform_jump move
        true
      else
        raise InvalidMoveError
      end
      
    end
  end
  
  def valid_move_seq?(sequence)
    new_board = @board.deep_dup

    piece = new_board[@position].piece
    
    begin
      piece.perform_moves!(sequence)
    rescue InvalidMoveError
      return false
    else
      return true
    end
    
  end
  
  def perform_moves(sequence)
    if valid_move_seq?(sequence) 
      perform_moves!(sequence) 
    else
      raise InvalidMoveError
    end
  end
  
  def handle_jumped_piece(target)
    dead_piece = get_dead_piece(target)
    kill_piece dead_piece
  end
  
end