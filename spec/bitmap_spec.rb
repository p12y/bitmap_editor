require_relative '../lib/bitmap'

describe Bitmap do

  it "renders the correct size" do
    @bitmap = Bitmap.new(1, 2)
    expect(@bitmap.width).to eq 1
    expect(@bitmap.length).to eq 2
  end

end