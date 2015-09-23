require 'ff_task_generator/xml_generator'
require 'nokogiri'

describe FfTaskGenerator::XMLGenerator do
  let!(:root) { File.expand_path('../..',__FILE__) }
  let!(:input_path) { File.join(root, 'fixtures', 'input_dir') }
  let!(:template_path) { File.join(root, 'fixtures', 'template.xml.erb') }

  context 'without task' do
    let!(:reader) { FfTaskGenerator::InputDirReader.new(path: input_path, range: 0..1, input_path: 'Z:\\input', output_path: 'Z:\\output') }

    it 'renders XML with 32*2 tasks' do
      tasks = reader.input_files
      xml = described_class.new(template_path, tasks).generate

      doc = Nokogiri::XML(xml)
      expect(doc.xpath('//Task').count).to eq(64)
    end
  end

  context 'with task' do
    let!(:files) { Dir["#{input_path}/**/*"].select{|f| File.file?(f) && File.extname(f) == '.png' } }

    let!(:task) {
      files.map do |path|
        {
            count: 100,
            path: path
        }
      end
    }

    let!(:reader) { FfTaskGenerator::InputDirReader.new(path: input_path, range: 0..1, input_path: 'Z:\\input', output_path: 'Z:\\output', task: task) }

    it 'renders XML with 32*2 tasks' do
      tasks = reader.input_files
      xml = described_class.new(template_path, tasks).generate

      doc = Nokogiri::XML(xml)
      expect(doc.xpath('//Task').count).to eq(3200)
    end
  end
end