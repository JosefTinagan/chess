class Board
	attr_reader :grid
	def initialize(grid = default_grid)
		@grid = grid
	end

	def starting_pieces
		
	end

	def show_grid
		grid.each do |row|
			puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
		end
	end

	def default_grid
		Array.new(8) { Array.new(8) { Cell.new }}
	end
end