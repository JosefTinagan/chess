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

	def remove_item(x,y)
		get_cell(x,y).value = ""
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

		black_backline = [black_rook_piece, black_knight_piece, black_bishop_piece, black_queen_piece,
						black_king_piece, black_bishop_piece, black_knight_piece, black_rook_piece
						]

		white_backline = [ white_rook_piece, white_knight_piece, white_bishop_piece, white_queen_piece,
						white_king_piece, white_bishop_piece, white_knight_piece, white_rook_piece
						]

		iterator = 0
		grid[0].each do |x|
			x.value = black_backline[iterator]
			iterator += 1 
		end

		grid[1].each do |x|
			x.value = black_pawn_piece
		end

		grid[6].each do |x|
			x.value = white_pawn_piece
		end

		iterator = 0 
		grid[7].each do |x|
			x.value = white_backline[iterator]
			iterator += 1 
		end
	end

	def show_grid
		puts "Showing board..."
		grid.each do |row|
			puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
		end
	end

	def default_grid
		Array.new(8) { Array.new(8) { Cell.new }}
	end
end