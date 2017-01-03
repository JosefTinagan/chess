require 'cell'

describe Cell do 
	context "#initialize" do
		it "initializes value with a nil" do
			c = Cell.new
			expect(c.value).to eq ""
		end

		it "initialize starting_position with true" do
			c = Cell.new
			expect(c.starting_position).to eq true
		end

		it "initialize type to an empty string" do
			 c = Cell.new
			 expect(c.type).to eq ""
		end

		it "returns PAWN when passed a type PAWN" do
			c = Cell.new(true,"PAWN")
			expect(c.type).to eq "PAWN"
			expect(c.starting_position).to eq true
		end
	end
end