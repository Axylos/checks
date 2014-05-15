class Tile
  
  attr_reader :location, :color, :piece
  attr_accessor
  
  
  def initialize(row, col, board)
    
    @location = [row, col]
    @color = decide_color(row, col)
    @board = board
    @piece = nil
    
  end
  
  def decide_color(row, col)
    (row + col).even? ? :red : :black
  end
  
  def occupied?
    !@piece.nil?
  end
  
  def empty?
    !occupied?
  end
  
  def add_piece(piece)
    @piece = piece
  end
  
  def get_piece
    @piece
  end
  
  def remove_piece
    @piece = nil
  end
  
  def is_black?
    @color == :black
  end
 
end