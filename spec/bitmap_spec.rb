require_relative '../lib/bitmap'

describe Bitmap do

  it "renders the correct size" do
    @bitmap = Bitmap.new(1, 2)
    expect(@bitmap.width).to eq 1
    expect(@bitmap.length).to eq 2
  end

  it "is valid with correct coords" do
    @bitmap = Bitmap.new(2, 2)
    expect(@bitmap.valid?).to eq true
  end

  it "is invalid with coords less than one" do
    @bitmap = Bitmap.new(1, 0)
    expect(@bitmap.valid?).to eq false
  end

  it "is invalid with coords grater than 250" do
    @bitmap = Bitmap.new(1, 251)
    expect(@bitmap.valid?).to eq false
  end

end