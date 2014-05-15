#!/usr/bin/env ruby
require "debugger"
require "./display.rb"
require "./make_board.rb"

class Piece
  
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end
  
  def move_diffs
    row, col = @position
    diff = green? ? -1 : 1
    [
      [row + diff, col - 1],
      [row + diff, col + 1],
      [row + (diff * 2), col - 1],
      [row + (diff * 2), col + 1]
    ]
  end
  
  def valid_moves
    valid_moves = []
    row, col = @position
    diff = green? ? -1 : 1
    
    valid_moves << [row + diff, col - 1]
    valid_moves << [row + diff, col + 1]
    
    valid_moves << [row + (diff * 2), col - 1]
    valid_moves << [row + (diff * 2), col + 1]
    
    valid_moves.reject { |move| @board[move].occupied? }
    
  end
  
  def perform_jump(target)
    return false if !(valid_moves.include?(target))
  end
  
  def perform_slide(target)
    return false if !(valid_moves.include?(target))
    
    move(target)
  end
  
  def green?
    @color == :green
  end
  
  def orange?
    !green?
  end
  
  def move(target)
    @position = target
    @board.move_piece(self, target)
  end
  
end


class Board
  include GenerateBoard
  include DisplayBoard
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    
    make_board
    
    make_starting_pieces
  end
  
end

class Tile
  
  attr_reader :location, :color, :piece
  
  
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
  
  def is_black?
    @color == :black
  end
 
end