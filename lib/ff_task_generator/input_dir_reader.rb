require 'erb'

class FfTaskGenerator::InputDirReader
  def initialize(path:, range:, template_path:, input_path:, output_path:, task: nil)
    @path = path
    @range = range
    @template_path = template_path
    @input_path = input_path
    @output_path = output_path
    @task = (task || []).group_by{ |sign| sign[:path] }
  end

  def generate_xml!
    create_input_files!
    template = ERB.new(File.new(@template_path).read, nil, '%')
    template.result(binding)
  end

  private

  def input_files
    @input_files ||= Dir["#{@path}/**/*"].select{|f| File.file?(f) && File.extname(f) == '.png' }
  end

  def create_input_files!
    @files = input_files.each_with_object([]) do |f, ary|
      range(f).each do |preset|
        ary << FfTaskGenerator::InputFile.new(input_root: @path, path: f, preset: preset, input_path: @input_path, output_path: @output_path)
      end
    end
  end

  def range(file)
    if @task[file].present?
      0..@task[file].first[:count]
    else
      @range
    end
  end
end