require 'board'

describe Board do 
	let(:test) { Board.new }
	context "#initialize" do
		it "initializes a board an array of 8 x 8" do
			b = Board.new
			expect(b.grid).to be_instance_of(Array)
		end
	end

	context "get_cell" do

	end

	context "set_cell" do

	end

	context "#show_grid" do
		it "shows current state of grid" do
			test.show_grid
		end	
	end

	context "#starting_pieces" do
		it "initializes starting pieces" do
			test.starting_pieces
			test.show_grid
		end
	end
end