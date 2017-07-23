require_relative '../lib/bitmap_editor'

describe BitmapEditor do
  before :each do
    @bitmap_editor = BitmapEditor.new
    @bitmap = @bitmap_editor.create_bitmap(2, 2)
  end

  it "creates bitmap" do
    expect(@bitmap).to be_instance_of Bitmap
  end

  it "shows bitmap" do
    expect do
      @bitmap_editor.show
    end.to output("OO\nOO\n").to_stdout
  end

  it "colors horizontal segment" do
    @bitmap = @bitmap_editor.create_bitmap(4, 3)
    @bitmap_editor.color_horizontal_segment(2, 3, 1, "Y")
    expect do
      @bitmap_editor.show
    end.to output("OYYO\nOOOO\n\OOOO\n").to_stdout
  end

  it "colors vertical segment" do
    @bitmap = @bitmap_editor.create_bitmap(3, 4)
    @bitmap_editor.color_vertical_segment(2, 2, 3, "Y")
    expect do
      @bitmap_editor.show
    end.to output("OOO\nOYO\nOYO\nOOO\n").to_stdout
  end

  it "clears grid" do
    @bitmap_editor.color_vertical_segment(1, 1, 2, "Y")
    @bitmap_editor.clear_grid
    expect do
      @bitmap_editor.show
    end.to output("OO\nOO\n").to_stdout
  end


  
end