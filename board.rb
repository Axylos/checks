require 'debugger'
require 'pry'
class Board
  include GenerateBoard
  include DisplayBoard
  
  attr_reader :pieces_on_board
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    @pieces_on_board = []
    
    make_board
    make_starting_pieces
  end
  
  def move_piece(piece, target)
    puts "called"
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
  
  def deep_dup
    new_board = Board.new
    
    @grid.each do |row|
      row.each do |tile|
        next if tile.empty?
        old_piece = tile.piece
        new_piece = Piece.new(old_piece.color, old_piece.position, new_board)
        new_board[tile.location].add_piece new_piece
      end
      
    end
    new_board
  end
  
  def add_piece(piece)
    @pieces_on_board << piece
  end
  
  def remove_piece(piece)
    pos = piece.position
    @pieces_on_board.delete piece
    self[pos].remove_piece
  end
  
end