class FfTaskGenerator::InputFile
  attr_reader :preset, :relative_path, :input_path, :output_path, :name, :path

  def initialize(input_root:, path:, preset:, input_path:, output_path:)
    file_pathname = Pathname.new(path)
    input_root_pathname = Pathname.new(input_root)

    @relative_path = file_pathname.relative_path_from(input_root_pathname).to_s
    @preset = preset

    @input_path = input_path
    @output_path = output_path

    extension = File.extname(path)
    @name = File.basename(path, extension)
    @path = File.dirname(@relative_path).gsub('/', '\\')
  end

  def docker_input_path
    "#{@input_path}\\#{@relative_path.gsub('/', '\\')}"
  end

  def docker_output_path
    if @path == '.'
      "#{@output_path}\\#{@name}_synth_#{@preset}.jpg"
    else
      "#{@output_path}\\#{@path}\\#{@name}_synth_#{@preset}.jpg"
    end
  end
end