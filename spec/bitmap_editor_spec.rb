require_relative '../lib/bitmap_editor'
require 'stringio'

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
    expect {
      @bitmap_editor.show
    }.to output("OO\nOO\n").to_stdout
  end

  it "colors horizontal segment" do
    @bitmap = @bitmap_editor.create_bitmap(4, 3)
    @bitmap_editor.color_horizontal_segment(coords: {col1: 2, col2: 3, row: 1}, color: "Y")
    expect {
      @bitmap_editor.show
    }.to output("OYYO\nOOOO\n\OOOO\n").to_stdout
  end

  it "colors vertical segment" do
    @bitmap = @bitmap_editor.create_bitmap(3, 4)
    @bitmap_editor.color_vertical_segment(coords: {col: 2, row1: 2, row2: 3}, color: "Y")
    expect {
      @bitmap_editor.show
    }.to output("OOO\nOYO\nOYO\nOOO\n").to_stdout
  end

  it "clears grid" do
    @bitmap = @bitmap_editor.create_bitmap(2, 2)
    @bitmap_editor.color_vertical_segment(coords: {col: 1, row1: 1, row2: 2}, color: "Y")
    @bitmap_editor.clear_grid
    expect {
      @bitmap_editor.show
    }.to output("OO\nOO\n").to_stdout
  end

  it "colors pixel" do
    @bitmap = @bitmap_editor.create_bitmap(2, 2)
    @bitmap_editor.color(coords: {col: 1, row: 2}, color: "Y")
    expect {
      @bitmap_editor.show
    }.to output("OO\nYO\n").to_stdout
  end

  it "fails gracefully with incorrect size" do
    expect {
      expect { @bitmap = @bitmap_editor.create_bitmap(0, 4) }.to raise_error(SystemExit)
    }.to output("Invalid size\n").to_stderr
  end

  it "alerts user to create bitmap if command issued without bitmap" do
    expect {
      expect { @bitmap_editor.color(coords: {col: 1, row: 2}, color: "Y") }.to raise_error(SystemExit)
    }.to output("Create image before issuing commands\n").to_stderr
  end

  it "alerts user to provide file if no file provided" do
    expect {
      BitmapEditor.new.run(' ')
    }.to output("please provide correct file\n").to_stdout
  end

  it "alerts user to provide file if incorrect file provided" do
    expect {
      BitmapEditor.new.run('file')
    }.to output("please provide correct file\n").to_stdout
  end

  it "alerts user to provide file if incorrect file provided" do
    expect {
      expect { BitmapEditor.new.run("spec/fixtures/incorrect_command.txt")}.to raise_error(SystemExit)
    }.to output("'M' is not a recognised command\n").to_stderr
  end

  it "alerts if incorrect parameters provided" do
    expect {
      expect { BitmapEditor.new.run("spec/fixtures/incorrect_params.txt")}.to raise_error(SystemExit)
    }.to output("Command 'I' contains invalid parameters\n").to_stderr
  end

  describe '#fill' do
    it 'fills simple one-by-one bitmap' do
      @bitmap = @bitmap_editor.create_bitmap(1, 1)
      @bitmap.fill(1, 1, 'Y')
      expect {
        @bitmap_editor.show
      }.to output("Y\n").to_stdout
    end

    it 'fills two-by-one bitmap' do
      @bitmap = @bitmap_editor.create_bitmap(2, 1)
      @bitmap.fill(1, 1, "Y")
      expect {
        @bitmap_editor.show
      }.to output("YY\n").to_stdout
    end

    it 'stops at different color' do
      @bitmap = @bitmap_editor.create_bitmap(3, 1)
      @bitmap_editor.color(coords: {col: 2, row: 1}, color: 'X')
      @bitmap.fill(1, 1, "Y")
      expect {
        @bitmap_editor.show
      }.to output("YXO\n").to_stdout
    end

    it 'fills complex shape' do
      @bitmap = @bitmap_editor.create_bitmap(3, 3)
      @bitmap_editor.color(coords: {col: 2, row: 2}, color: 'X')
      @bitmap.fill(1, 1, "Y")
      expect {
        @bitmap_editor.show
      }.to output("YYY\nYXY\nYYY").to_stdout
    end
  end

  
end