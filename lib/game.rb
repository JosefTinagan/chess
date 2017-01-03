class Game
	attr_reader :board
	def initialize(board=Board.new)
		@board = board
		board.starting_pieces
	end

	def play
		puts "This is the current board:"
		board.show_grid
		puts solicit_move
		starting_position,ending_position = gets.chomp.split(" ")
		if mapping_choice(starting_position) && mapping_choice(ending_position)
			a = mapping_choice(starting_position)
			b = mapping_choice(ending_position)
			if valid_move?(a,b)

			else
				
			end
		else
			puts "Invalid choice...Try again."
		end
	end
	
	def valid_move?(start_pos,end_pos)
		type = board.get_cell(start_pos[0],start_pos[1]).type
		if type == "PAWN"
			valid = board.pawn_move(start_pos,end_pos)
			return valid
		else

		end
	end

	def solicit_move
		return "Type a command(e.g. a7 a6). Separated by a space"
	end

	def mapping_choice(choice)
		mapping = {
			"a8" => [0,0],
			"a7" => [0,1],
			"a6" => [0,2],
			"a5" => [0,3],
			"a4" => [0,4],
			"a3" => [0,5],
			"a2" => [0,6],
			"a1" => [0,7]
		}
		if mapping[choice] != nil
			tmp = mapping[choice]
			#puts board.get_cell(tmp[0],tmp[1]).type
			tmp
		else
			false
		end
	end
end