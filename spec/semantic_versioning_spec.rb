require 'rspec'
require 'semantic_versioning'

describe SemanticVersioning do
  subject(:versioning_test) do
    versioning_test = SemanticVersioning.new
  end

  describe '#comparator' do
    it 'should compare the two versions' do
      expect(versioning_test.comparator('1.3.6', '1.4.2')).to eq('before')
      expect(versioning_test.comparator('4.2.3-beta', '4.2.3-alpha')).to eq('after')
      expect(versioning_test.comparator('1.6.3', '1.6.3')).to eq('equal')
    end
  end

  describe '#valid_input?' do
    it 'should return true when the input is valid' do
      expect(versioning_test.valid_input?('1.3.6 1.4.2')).to eq(true)
      expect(versioning_test.valid_input?('4.2.3-beta  4.2.3-alpha')).to eq(true)
    end

    it 'should return false when the input is invalid' do
      expect(versioning_test.valid_input?('1.7.9 1.3.5 0.0.2')).to eq(false)
      expect(versioning_test.valid_input?('1.6 1.6.3')).to eq(false)
      expect(versioning_test.valid_input?('1.668 1.6.3')).to eq(false)
      expect(versioning_test.valid_input?('-1.6.6 1.6.3')).to eq(false)
      expect(versioning_test.valid_input?('0.6.6 1.6.3')).to eq(false)
    end
  end

  describe '#parse_input' do
    it 'should return an array with the input parsed' do
      expect(versioning_test.parse_input('1.3.6 1.4.2')).to eq(['1.3.6', '1.4.2'])
      expect(versioning_test.parse_input('4.2.3-beta  4.2.3-alpha')).to eq(['4.2.3-beta',  '4.2.3-alpha'])
    end
  end

  describe '#postfix?' do
    it 'should return true when the input has a postfix' do
      expect(versioning_test.postfix?('4.2.3-beta', '4.2.3-alpha')).to eq(true)
      expect(versioning_test.postfix?('4.2.3-gamma', '4.2.3-delta')).to eq(true)
    end

    it 'should return false when the input does not have a postfix' do
      expect(versioning_test.postfix?('1.3.6', '1.4.2')).to eq(false)
      expect(versioning_test.postfix?('1.3.6', '1.4.2')).to eq(false)
    end
  end

  describe '#postfix' do
    it 'should evaluate the versions if they both have a postfix' do
      expect(versioning_test.postfix('4.2.3-beta', '4.2.3-alpha')).to eq('after')
      expect(versioning_test.postfix('4.2.3-delta', '4.2.3-gamma')).to eq('before')
    end
  end

  describe 'the variable: outputs' do
    it 'should store all of the intended terminal outputs in an array' do
      versioning_test.comparator('1.3.6', '1.4.2')
      versioning_test.comparator('4.2.3-beta', '4.2.3-alpha')
      versioning_test.comparator('1.6.3', '1.6.3')
      expect(versioning_test.outputs).to eq(['before', 'after', 'equal'])
    end
  end

end
