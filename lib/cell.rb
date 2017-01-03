class Cell
	attr_accessor :value, :starting_position, :type, :color
	def initialize(starting_position=false,type="",value="",color="")
		@value = value
		@starting_position = starting_position
		@type = type
		@color = color
	end
end