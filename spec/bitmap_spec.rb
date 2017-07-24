require_relative '../lib/bitmap'

describe Bitmap do

  it "renders the correct size" do
    @bitmap = Bitmap.new(1, 2)
    expect(@bitmap.width).to eq 1
    expect(@bitmap.length).to eq 2
  end

  it "validates pixel coordinates" do
    @bitmap = Bitmap.new(1, 250)
    expect(@bitmap.valid?).to eq false
  end

end