require 'ff_task_generator/input_dir_reader'

describe FfTaskGenerator::InputDirReader do
  let!(:root) { File.expand_path('../..',__FILE__) }

  let!(:input_path) { File.join(root, 'fixtures', 'input_dir') }

  context 'without task' do
    let!(:reader) { described_class.new(path: input_path, range: 0..1, input_path: 'Z:\\input', output_path: 'Z:\\output') }

    describe '#input_files' do
      it 'returns array with 32*2 elements' do
        expect(reader.input_files.count).to eq(64)
      end
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

    let!(:reader) { described_class.new(path: input_path, range: 0..1, input_path: 'Z:\\input', output_path: 'Z:\\output', task: task) }

    describe '#input_files' do
      it 'returns array with 32*100 elements' do
        expect(reader.input_files.count).to eq(3200)
      end
    end
  end
end