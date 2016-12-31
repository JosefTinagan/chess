require 'cell'

describe Cell do 
	context "#initialize" do
		it "initializes value with a nil" do
			c = Cell.new
			expect(c.value).to eq ""
		end
	end
end