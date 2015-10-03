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
    @files = Dir["#{@path}/**/*"].select{ |f| File.file?(f) && %w(.jpg .png).include?(File.extname(f)) }.each_with_object([]) do |f, ary|
      range(f).each do |preset|
        ary << FfTaskGenerator::InputFile.new(input_root: @path, path: f, preset: preset, input_path: @input_path, output_path: @output_path)
      end
    end
  end

  private

  def range(file)
    if !@task[file].nil?
      1...(@task[file].first[:count] + 1)
    else
      @range
    end
  end
end