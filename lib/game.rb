class Game
	attr_reader :board
	def initialize(board=Board.new)
		@board = board
		board.starting_pieces
	end

	def play
		while true
			puts "This is the current board:"
			board.show_grid
			puts solicit_move
			starting_position,ending_position = gets.chomp.split(" ")
			if mapping_choice(starting_position) && mapping_choice(ending_position)
				a = mapping_choice(starting_position)
				b = mapping_choice(ending_position)
				if a == b
					puts "Same move"
					play
				elsif valid_move?(a,b)
					puts "Valid move... proceeding."
					tmp = board.get_cell(a[0],a[1])
					x = b[0]
					y = b[1]

		
					board.set_cell(x,y,tmp.value)
					board.set_cell_type(x,y,tmp.type)
					board.set_cell_color(x,y,tmp.color)
					board.set_cell_position(x,y,false)
					board.remove_item(a[0],a[1])
				else
					puts "Invalid choice...Try again"
					play
				end
			else
				puts "Invalid choice...Try again."
				play
			end
		end
	end
	
	def valid_move?(start_pos,end_pos)
		type = board.get_cell(start_pos[0],start_pos[1]).type
		if type == "PAWN"
			valid = board.pawn_move(start_pos,end_pos)
		elsif type == "ROOK"
			valid = board.rook_move(start_pos,end_pos)
		else

		end

		return valid
	end

	def solicit_move
		return "Type a command(e.g. a7 a6). Separated by a space"
	end

	def mapping_choice(choice)
		mapping = {
			"a8" => [0,0], "a7" => [0,1], "a6" => [0,2], "a5" => [0,3], "a4" => [0,4], "a3" => [0,5], "a2" => [0,6], "a1" => [0,7],
			"b8" => [1,0], "b7" => [1,1], "b6" => [1,2], "b5" => [1,3], "b4" => [1,4], "b3" => [1,5], "b2" => [1,6], "b1" => [1,7],
			"c8" => [2,0], "c7" => [2,1], "c6" => [2,2], "c5" => [2,3], "c4" => [2,4], "c3" => [2,5], "c2" => [2,6], "c1" => [2,7],
			"d8" => [3,0], "d7" => [3,1], "d6" => [3,2], "d5" => [3,3], "d4" => [3,4], "d3" => [3,5], "d2" => [3,6], "d1" => [3,7],
			"e8" => [4,0], "e7" => [4,1], "e6" => [4,2], "e5" => [4,3], "e4" => [4,4], "e3" => [4,5], "e2" => [4,6], "e1" => [4,7],
			"f8" => [5,0], "f7" => [5,1], "f6" => [5,2], "f5" => [5,3], "f4" => [5,4], "f3" => [5,5], "f2" => [5,6], "f1" => [5,7],
			"g8" => [6,0], "g7" => [6,1], "g6" => [6,2], "g5" => [6,3], "g4" => [6,4], "g3" => [6,5], "g2" => [6,6], "g1" => [6,7],
			"h8" => [7,0], "h7" => [7,1], "h6" => [7,2], "h5" => [7,3], "h4" => [7,4], "h3" => [7,5], "h2" => [7,6], "h1" => [7,7]
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