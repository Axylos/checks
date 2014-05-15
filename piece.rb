require "./movement.rb"

class InvalidMoveError < StandardError
end
class Piece
  include Movement
    
  attr_reader :position, :color, :jumped
  
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    @jumped = Hash.new
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
  
  def king?
    @king == true
  end
  
  def handle_jumped_piece(target)
    dead_piece = get_dead_piece(target)
    kill_piece dead_piece
  end
  
  def kill_piece(piece)
    @board.remove_piece(piece)
    piece.die
  end
  
  def get_dead_piece(target)
    jumps = move_diffs
    move = jumps.select { |slide, jump| jump == target }
    jumper = move[0][0]
    @board[jumper].piece
  end

  def green?
    @color == :green
  end
  
  def orange?
    !green?
  end
  
  def perform_moves!(*move_sequence)
    many = move_sequence.count > 1
    
    move_sequence.each do |move|
      binding.pry
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