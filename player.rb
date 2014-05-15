class Player
  
  attr_accessor :color
  
  def get_move
    moves = []
    
    
    
      
      puts "Enter a starting position:"
      start_pos = parse_input(gets.chomp)
      moves << start_pos
      
      stop = false
      until stop
      
      puts "Enter a spot to move to:"
      move = parse_input(gets.chomp)
      
      moves << move 
      
      puts "Is that the last move? (y/n)"
      if gets.chomp[0].downcase == "y"
        stop = true
      end
    end
    
    moves
  end
  
  def parse_input(input)
    input.scan(/\d+/).map(&:to_i)
  end
  
end