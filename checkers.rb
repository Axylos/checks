#!/usr/bin/env ruby
require "debugger"
require "pry"
require "./display.rb"
require "./make_board.rb"
require "./board.rb"
require "./tile.rb"
require "./piece.rb"

b = Board.new

b.move [5, 2], [4, 3]
b.move [2, 3], [3, 4]
b.display_board

piece = b[[3, 4]].piece
dead = b[[4, 3]].piece

dud = b[[2, 3]].piece
pry





