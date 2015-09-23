class FfTaskGenerator::XMLGenerator
  def initialize(template_path, files)
    @template_path = template_path
    @files = files
  end

  def generate
    template = ERB.new(File.new(@template_path).read, nil, '%')
    template.result(binding)
  end
end