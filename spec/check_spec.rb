require_relative '../lib/check.rb'

describe ErrCheck do
  let(:checker) { ErrCheck.new('test.rb') }
  describe '#trailing_spaces' do
    it 'should return trailing space error on line 3' do
      checker.trailing_spaces
      expect(checker.errors[0]).to eq('On line:18:18: Error: Trailing whitespace detected.')
    end
  end

  let(:checker) { ErrCheck.new('test.rb') }
  describe '#trailing_spaces' do
    it 'should return trailing space error on line 3' do
      checker.trailing_spaces
      expect(checker.errors[0]).not_to be('On line:19 Lint/Syntax: Unexpected/Missing token ')
    end
  end

  describe '#tag_error' do
    it 'returns missing or unexpected tags eg ( ), [ ], and { }' do
      checker.tag_error
      expect(checker.errors[0]).to eq("line:19 Lint/Syntax: Unexpected/Missing token ')' Parenthesis")
    end
  end
  describe '#tag_error' do
    it 'returns missing or unexpected tags eg ( ), [ ], and { }' do
      checker.tag_error
      expect(checker.errors[0]).not_to eq("line:19 Lint/Syntax: Unexpected/Missing token ')' Parenthesis ")
    end
  end

  describe '#end_error' do
    it 'returns missing/unexpected end' do
      checker.end_error
      expect(checker.errors[0]).to eq("Lint/Syntax: Missing 'end'")
    end
  end

  describe '#end_error' do
    it 'returns missing/unexpected end' do
      checker.end_error
      expect(checker.errors[0]).not_to eq("Lint/Syntax: Missing 'end' ")
    end
  end

  describe '#empty_line_error' do
    it 'returns empty line error' do
      checker.empty_line_error
      expect(checker.errors[0]).to eql('line:17 Extra empty line detected at method body beginning')
    end
  end

  describe '#empty_line_error' do
    it 'returns empty line error' do
      checker.empty_line_error
      expect(checker.errors[0]).not_to eql('line:17 Extra empty line detected at method body beginning ')
    end
  end
end
