require 'erb'

class FfTaskGenerator::InputDirReader
  def initialize(path:, range:, input_path:, output_path:, task: nil)
    @path = path
    @range = range
    @input_path = input_path
    @output_path = output_path
    @task = (task || []).group_by{ |sign| sign[:path] }
  end

  def input_files
    @files = Dir["#{@path}/**/*"].select{ |f| File.file?(f) && File.extname(f) == '.png' }.each_with_object([]) do |f, ary|
      range(f).each do |preset|
        ary << FfTaskGenerator::InputFile.new(input_root: @path, path: f, preset: preset, input_path: @input_path, output_path: @output_path)
      end
    end
  end

  private

  def range(file)
    if !@task[file].nil?
      0...@task[file].first[:count]
    else
      @range
    end
  end
end