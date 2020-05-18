require_relative '../lib/books_scraper'

describe Books do
  let(:webscraper) { Books.new }

  describe '#initialize' do
    it 'url should not be an empty string' do
      expect(webscraper.instance_variable_get(:@url)).not_to eq('')
    end

    it 'should check if list of books is an empty array' do
      expect(webscraper.instance_variable_get(:@list_of_books)).to eq([])
    end

    it 'list of books should not have any elements in array ' do
      expect(webscraper.instance_variable_get(:@list_of_books)).not_to eq([''])
    end
  end

  describe '#top_books' do
    it 'returns an array' do
      hashed_books = webscraper.top_books
      expect(hashed_books).to be_an(Array)
    end
  end

  it 'should not be empty' do
    expect(webscraper.top_books).to_not eql(nil)
  end
end
