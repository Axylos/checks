#!/usr/bin/env ruby
require "debugger"

class Piece
  
  def initialize(color, position)
    @color = color
    @position = position
  end
  
  def perform_slide(dir)
    
    
  end
  
  def move_diffs
    valid_moves = []
    row, col = @position
    diff = green? ? -1 : 1
    
    slide_left = [row + diff, col - 1]
    slide_right = [row + diff, col + 1]
    
    jump_left = [row + (diff * 2), col - 1]
    jump_right = [row + (diff * 2), col + 1]
    
     
  end
  
  def perform_jump
    
  end
  
  def green?
    @color == :green
  end
  
  def orange?
    !green?
  end
  
end


class Board
  
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    
    make_board
    
    make_starting_pieces
  end
  
  def make_board
    8.times do |row|
      8.times do |col|

        new_tile = Tile.new(row, col, self)
        
        add_tile(new_tile)
      end
    end

  end
  
  def add_tile(tile)
    self[tile.location] = tile
  end
  
  def [](pos)
    row, col = pos
    @grid[row][col]
  end
  
  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end
  
  def display_board
    8.times do |row|
      line = []
      
      8.times do |col|
        square = self[[row, col]]
        if square.empty?
          if square.color == :black
            line << "_*_"
          else
            line << "|_|"
          end
        else
          if square.piece.green?
            line << "_G_"
          else
            line << "_O_"
          end
        end
        
      end
      puts line.join("")
    end
    
  end
  
  def make_starting_pieces
   8.times do |row|
      
      8.times do |col|
        pos = [row, col]
        place = self[pos]
        if place.is_black?
          if row < 3
            place.add_piece Piece.new(:orange, [row, col]) 
          elsif row > 4
            place.add_piece Piece.new(:green, [row, col])
          end
        end
      end
    end
    
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