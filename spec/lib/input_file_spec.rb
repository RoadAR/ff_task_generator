require 'ff_task_generator/input_file'

describe FfTaskGenerator::InputFile do
  context 'without relative path' do
    let!(:input_file) { described_class.new(input_root: '/tmp/input', path: '/tmp/input/1.png', preset: '123', input_path: 'Z:\\input', output_path: 'Z:\\output') }

    describe '#docker_input_path' do
      it 'returns input path in wine notation for docker' do
        expect(input_file.docker_input_path).to eq('Z:\\input\\1.png')
      end
    end

    describe '#docker_output_path' do
      it 'returns output path in wine notation for docker' do
        expect(input_file.docker_output_path).to eq('Z:\\output\\1_synth_123.png')
      end
    end
  end

  context 'with relative path' do
    let!(:input_file) { described_class.new(input_root: '/tmp/input', path: '/tmp/input/test/1.png', preset: '123', input_path: 'Z:\\input', output_path: 'Z:\\output') }

    describe '#docker_input_path' do
      it 'returns input path in wine notation for docker' do
        expect(input_file.docker_input_path).to eq('Z:\\input\\test\\1.png')
      end
    end

    describe '#docker_output_path' do
      it 'returns output path in wine notation for docker' do
        expect(input_file.docker_output_path).to eq('Z:\\output\\test\\1_synth_123.png')
      end
    end
  end
end