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

  it "alerts user if row coords out of bounds" do
    @bitmap = Bitmap.new(1, 2)
    expect {
      expect { @bitmap.color(coords: {col: 1, row: 5}, color: "Y") }.to raise_error(SystemExit)
    }.to output("Row coordinates must be between 1 and 2\n").to_stderr
  end

  it "alerts user if col coords out of bounds" do
    @bitmap = Bitmap.new(1, 2)
    expect {
      expect { @bitmap.color(coords: {col: 0, row: 5}, color: "Y") }.to raise_error(SystemExit)
    }.to output("Column coordinates must be between 1 and 1\n").to_stderr
  end

end