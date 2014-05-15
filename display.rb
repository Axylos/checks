module DisplayBoard
  def display_board
    puts "   0  1  2  3  4  5  6  7"
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
      print row, " "
      puts line.join("")
    end
    
  end

end