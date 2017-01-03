require 'game'

describe Game do
	let(:game) { Game.new } 
	context "#initialize" do
		it "initializes the board" do
			expect(game.board).to be_an_instance_of(Board)
		end
	end

	context "#play" do
		it "tests the method play" do
			game.play
		end
	end

	context "#valid_move?" do
		it "tests valid_move? method" do
			game.valid_move?([0,1],[0,2])
		end
	end

	context "#solicit_move" do
		it "returns 'Type a command(e.g. a7 a6). Separated by a space'" do
			expected_response = 'Type a command(e.g. a7 a6). Separated by a space'
			expect(game.solicit_move).to eql(expected_response)
		end
	end

	context "#mapping_choice" do
		it "if passed a8 returns [0,0]" do
			expect(game.mapping_choice("a8")).to eq [0,0]
		end

		it "if passed a7 returns [0,1]" do
			expect(game.mapping_choice("a7")).to eq [0,1]
		end

		it "returns false if passed invalidd choice" do
			expect(game.mapping_choice("j2")).to eq false
		end
	end
end