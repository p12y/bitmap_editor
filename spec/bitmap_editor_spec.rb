require_relative '../lib/bitmap_editor'

describe BitmapEditor do
  before :each do
    @bitmap_editor = BitmapEditor.new
  end

  it "creates bitmap" do
    @bitmap = @bitmap_editor.create_bitmap(2, 2)
    expect(@bitmap).to be_instance_of Bitmap
  end

  it "shows bitmap" do
    @bitmap = @bitmap_editor.create_bitmap(2, 2)
    expect do
      @bitmap_editor.show
    end.to output("OO\nOO\n").to_stdout
  end
  
end