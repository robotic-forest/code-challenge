require 'rspec'
require_relative 'parser'

describe FantasticParser do
  fantastic_parser = FantasticParser.new()

  shared_examples 'fantastic parser' do |source|
    before :all do
      @result = fantastic_parser.parse(source).to_hash()
    end

    it 'should return a hash contining an non-empty artworks array' do
      expect(@result).to be_a(Hash)
      expect(@result).to include(:artworks)
      expect(@result[:artworks]).to be_a(Array)
      expect(@result[:artworks].length).to be > 0
    end

    it 'should have an artworks array with a certain structure' do
      @result[:artworks].each do |artwork|
        expect(artwork).to include(:name)
        expect(artwork[:name]).to be_a(String)
        expect(artwork[:name].length).to be > 0

        expect(artwork).to include(:link)
        expect(artwork[:link]).to be_a(String)
        expect(artwork[:link].length).to be > 0

        expect(artwork).to include(:image)
        expect(artwork[:image]).to be_a(String)
        expect(artwork[:image].length).to be > 0
      end
    end
  end

  context 'when initialized with a file path' do
    include_examples 'fantastic parser', "files/van-gogh-paintings.html"
  end

  context 'when initialized with a url, picasso example' do
    include_examples 'fantastic parser', "https://www.google.com/search?q=picasso+paintings"
  end

  context 'when initialized with a url, ernst example' do
    include_examples 'fantastic parser', "https://www.google.com/search?q=max+ernst+paintings"
  end

  context 'when initialized with a url, bosch example' do
    include_examples 'fantastic parser', "https://www.google.com/search?q=hieronymus+bosch+paintings"
  end

  fantastic_parser.cleanup()
end