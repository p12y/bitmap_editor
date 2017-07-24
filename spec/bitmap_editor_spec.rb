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
    @bitmap = @bitmap_editor.create_bitmap(2, 2)
    @bitmap_editor.color_vertical_segment(1, 1, 2, "Y")
    @bitmap_editor.clear_grid
    expect do
      @bitmap_editor.show
    end.to output("OO\nOO\n").to_stdout
  end

  it "colors pixel" do
    @bitmap = @bitmap_editor.create_bitmap(2, 2)
    @bitmap_editor.color(1, 2, "Y")
    expect do
      @bitmap_editor.show
    end.to output("OO\nYO\n").to_stdout
  end

  it "fails gracefully with incorrect size" do
    expect {
      expect { @bitmap = @bitmap_editor.create_bitmap(0, 4) }.to raise_error(SystemExit)
    }.to output("Invalid size\n").to_stderr
  end

  it "alerts user to create bitmap if command issued without bitmap" do
    expect {
      expect { @bitmap_editor.color(1, 2, "Y") }.to raise_error(SystemExit)
    }.to output("Create image before issuing commands\n").to_stderr
  end

  
end