class Board
	attr_reader :grid
	def initialize(grid = default_grid)
		@grid = grid
	end

	def get_cell(x,y)
		@grid[y][x]
	end

	def set_cell(x,y,value)
		get_cell(x,y).value = value
	end

	def set_cell_type(x,y,type)
		get_cell(x,y).type = type
	end

	def set_cell_color(x,y,color)
		get_cell(x,y).color = color
	end

	def set_cell_position(x,y,starting_position)
		get_cell(x,y).starting_position = starting_position
	end

	def remove_item(x,y)
		get_cell(x,y).value = ""
		get_cell(x,y).color = ""
		get_cell(x,y).type = ""
		get_cell(x,y).starting_position = false
	end

	def starting_pieces
		black_pawn_piece = "\u265F".encode("utf-8")
		black_rook_piece = "\u265C".encode("utf-8")
		black_knight_piece = "\u265E".encode("utf-8")
		black_bishop_piece = "\u265D".encode("utf-8")
		black_queen_piece = "\u265B".encode("utf-8")
		black_king_piece = "\u265A".encode("utf-8")

		white_pawn_piece = "\u2659".encode("utf-8")
		white_rook_piece = "\u2656".encode("utf-8")
		white_knight_piece = "\u2658".encode("utf-8")
		white_bishop_piece = "\u2657".encode("utf-8")
		white_queen_piece = "\u2655".encode("utf-8")
		white_king_piece = "\u2654".encode("utf-8")

		black_backline = [black_rook_piece, black_knight_piece, black_bishop_piece, black_king_piece, 
						  black_queen_piece,black_bishop_piece, black_knight_piece, black_rook_piece
						]

		white_backline = [ white_rook_piece, white_knight_piece, white_bishop_piece, white_queen_piece,
						white_king_piece, white_bishop_piece, white_knight_piece, white_rook_piece
						]
		
		rook_type= "ROOK"
		knight_type= "KNIGHT"
		bishop_type = "BISHOP"
		king_type = "KING"
		queen_type = "QUEEN"

		type_black_backline = [rook_type,knight_type,bishop_type,king_type,queen_type,
							bishop_type,knight_type,rook_type
							]
		type_white_backline = [rook_type,knight_type,bishop_type,queen_type,king_type,
							bishop_type,knight_type,rook_type]

		iterator = 0
		grid[0].each do |x|
			x.value = black_backline[iterator]
			x.type = type_black_backline[iterator]
			x.color = "BLACK"
			x.starting_position = true
			iterator += 1 

		end


		grid[1].each do |x|
			x.value = black_pawn_piece
			x.type = "PAWN"
			x.color = "BLACK"
			x.starting_position = true
		end

		grid[6].each do |x|
			x.value = white_pawn_piece
			x.type = "PAWN"
			x.color = "WHITE"
			x.starting_position = true
		end

		iterator = 0 
		grid[7].each do |x|
			x.value = white_backline[iterator]
			x.type = type_white_backline[iterator]
			x.color = "WHITE"
			x.starting_position = true
			iterator += 1 
		end
	end

	def pawn_move(start_pos,end_pos)
		tmp = get_cell(start_pos[0],start_pos[1])
		color = tmp.color
		valid_moves = []
		if color == "BLACK"
			if tmp.starting_position
				valid_moves.push([start_pos[0],start_pos[1] + 2])
				.push([start_pos[0], start_pos[1] + 1])
			else
				valid_moves.push([start_pos[0],start_pos[1] + 1])
			end
			#valid_moves.select! {|x| get_cell(x[0],x[1]).value == ""}
			#return valid_moves.include?(end_pos)
		elsif 
			if tmp.starting_position
				valid_moves.push([start_pos[0],start_pos[1] - 2])
				.push([start_pos[0], start_pos[1] - 1])
			else
				valid_moves.push([start_pos[0],start_pos[1] - 1])
			end
		end
		#puts "valid_moves main"
		#puts valid_moves.inspect
		valid_moves.select! { |x| get_cell(x[0],x[1]).value == ""}
		diagonals = pawn_move_diagonal(start_pos, end_pos)

		diagonals.each do |x|
			valid_moves.push(x)
		end
		#puts "in pawn_move"
		valid_moves.select! { |x| x[0] >= 0 && x[0] <= 7 && x[1] >= 0 && x[1] <= 7 }

		#puts valid_moves.inspect
		return valid_moves.include?(end_pos)
	end

	def pawn_move_diagonal(start_pos, end_pos)
		tmp = get_cell(start_pos[0],start_pos[1])
		color = tmp.color
		valid_moves = []
		if color == "BLACK"
			valid_moves.push([start_pos[0] + 1, start_pos[1] + 1])
			.push([start_pos[0] - 1, start_pos[1] + 1])
		else
			valid_moves.push([start_pos[0] + 1, start_pos[1] - 1])
			.push([start_pos[0] - 1, start_pos[1] - 1])
		end
		#puts valid_moves.inspect
		valid_moves.each do |x|
		#	puts get_cell(x[0],x[1]).type
		end
		valid_moves.select! { |x| x[0] >= 0 && x[0] <= 7 && x[1] >= 0 && x[1] <= 7 }
		valid_moves.select! { |x| !(get_cell(x[0],x[1]).type == "") }
		#puts "In pawn move diagonal..."
		#puts valid_moves.inspect
		
		return valid_moves
	end

	def rook_move(start_pos, end_pos)
		numbers_array = (1..7).to_a
		valid_moves = []
		tmp = get_cell(start_pos[0], start_pos[1])
		color = tmp.color

			numbers_array.each do |x|
				first_num = start_pos[0] + x
				second_num = start_pos[1]
				break if first_num > 7

				tmp_cell = get_cell(first_num,second_num)
				

				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

			numbers_array.each do |x|
				first_num = start_pos[0] - x
				second_num = start_pos[1]
				break if first_num < 0

				tmp_cell = get_cell(first_num,second_num)
				#check, like above
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

			numbers_array.each do |x|
				first_num = start_pos[0]
				second_num = start_pos[1] + x
				break if second_num > 7

				tmp_cell = get_cell(first_num,second_num)

				#check, like above
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

			numbers_array.each do |x|
				first_num = start_pos[0]
				second_num = start_pos[1] - x
				break if second_num < 0

				tmp_cell = get_cell(first_num,second_num)

				#check, like above
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

		valid_moves.select! { |x| x[0] >= 0 && x[0] <= 7 && x[1] >= 0 && x[1] <= 7}
		puts "Valid moves:"
		p valid_moves
		return valid_moves.include?(end_pos)
	end

	def knight_move(start_pos,end_pos)
		valid_moves = []
		a,b = start_pos[0], start_pos[1]
		tmp = get_cell(a,b)
		color = tmp.color

		valid_moves.push([a + 2, b - 1]).push([a + 2, b + 1]).push([a + 1, b - 2])
		.push([a + 1, b + 2]).push([a - 1, b - 2]).push([a - 1, b + 2]).push([a - 2, b - 1])
		.push([a - 2, b + 1])

		valid_moves.select!{ |x| x[0] >= 0 && x[0] <= 7 && x[1] >= 0 && x[1] <= 7 }
		tmp_arr = []
		
		valid_moves.each do |x|
			tmp_cell = get_cell(x[0],x[1])

			if tmp_cell.type == ""
				tmp_arr.push(x)
			else
				if tmp_cell.color != color
					tmp_arr.push(x)
				end
			end
		end
		valid_moves = tmp_arr
		return valid_moves.include?(end_pos)
	end

	def bishop_move(start_pos,end_pos)
		numbers_array = (1..7).to_a
		valid_moves = []
		tmp = get_cell(start_pos[0], start_pos[1])
		color = tmp.color

		numbers_array.each do |x|
				first_num = start_pos[0] + x
				second_num = start_pos[1] + x
				break if first_num > 7 || second_num > 7

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end

		numbers_array.each do |x|
				first_num = start_pos[0] - x
				second_num = start_pos[1] - x
				break if first_num < 0  || second_num < 0

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end

		numbers_array.each do |x|
				first_num = start_pos[0] - x
				second_num = start_pos[1] + x
				break if first_num < 0 || second_num > 7

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end

		numbers_array.each do |x|
				first_num = start_pos[0] + x
				second_num = start_pos[1] - x
				break if first_num > 7 || second_num < 0

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end

		valid_moves.select! { |x| x[0] >= 0 && x[0] <= 7 && x[1] >= 0 && x[1] <= 7}
		puts "Valid moves:"
		p valid_moves
		return valid_moves.include?(end_pos)
	end

	def queen_move(start_pos,end_pos)
		numbers_array = (1..7).to_a
		valid_moves = []
		tmp = get_cell(start_pos[0], start_pos[1])
		color = tmp.color

			numbers_array.each do |x|
				first_num = start_pos[0] + x
				second_num = start_pos[1]
				break if first_num > 7

				tmp_cell = get_cell(first_num,second_num)
				

				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

			numbers_array.each do |x|
				first_num = start_pos[0] - x
				second_num = start_pos[1]
				break if first_num < 0

				tmp_cell = get_cell(first_num,second_num)
				#check, like above
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

			numbers_array.each do |x|
				first_num = start_pos[0]
				second_num = start_pos[1] + x
				break if second_num > 7

				tmp_cell = get_cell(first_num,second_num)

				#check, like above
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

			numbers_array.each do |x|
				first_num = start_pos[0]
				second_num = start_pos[1] - x
				break if second_num < 0

				tmp_cell = get_cell(first_num,second_num)

				#check, like above
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
			end

			numbers_array.each do |x|
				first_num = start_pos[0] + x
				second_num = start_pos[1] + x
				break if first_num > 7 || second_num > 7

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end

		numbers_array.each do |x|
				first_num = start_pos[0] - x
				second_num = start_pos[1] - x
				break if first_num < 0  || second_num < 0

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end

		numbers_array.each do |x|
				first_num = start_pos[0] - x
				second_num = start_pos[1] + x
				break if first_num < 0 || second_num > 7

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end

		numbers_array.each do |x|
				first_num = start_pos[0] + x
				second_num = start_pos[1] - x
				break if first_num > 7 || second_num < 0

				tmp_cell = get_cell(first_num,second_num)
				
				#check if no piece is in the way, if enemy piece, can conquer it
				if !(tmp_cell.type == "")
					if !(tmp_cell.color == color)
						valid_moves.push([first_num,second_num])
					end
					break
				end
				valid_moves.push([first_num, second_num])
		end


		valid_moves.select! { |x| x[0] >= 0 && x[0] <= 7 && x[1] >= 0 && x[1] <= 7}
		puts "Valid moves:"
		p valid_moves
		return valid_moves.include?(end_pos)
	end

	def show_grid
		puts "Showing board..."
		i = 8
		grid.each do |row|
			x =  row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
			puts "#{x}  #{i}"
			i -= 1
		end
		puts "a b c d e f g h"
	end

	def default_grid
		Array.new(8) { Array.new(8) { Cell.new }}
	end
end