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
		it "returns the correct cell" do
			expect(test.get_cell(1,2).value).to eq  ""
		end
	end

	context "set_cell" do
		it "set and return the correct cell" do
			test.set_cell(0,0,"b")
			expect(test.get_cell(0,0).value).to eq "b"
		end
	end

	context "remove_item" do
		it "removes the value inside the cell" do
			test.starting_pieces
			test.remove_item(0,0)
			expect(test.get_cell(0,0).value).to eq ""
			#test.show_grid
		end
	end

	context "#show_grid" do
		it "shows current state of grid" do
			#test.show_grid
		end	
	end

	context "#starting_pieces" do
		it "initializes starting pieces" do
			test.starting_pieces
			test.show_grid
			z = test.get_cell(0,0).value
			test.set_cell(4,5,z) 
			test.show_grid
		end
	end


end