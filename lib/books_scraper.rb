# lib/books_scraper.rb
require 'nokogiri'
require 'open-uri'
require 'json'

class Books # :nodoc:
  URL = 'https://www.waterstones.com/campaign/books-of-the-month'.freeze

  def initialize
    @list_of_books = []
    @json_array = []
  end

  def top_books
    hash = extract_books
    return unless hash

    hash.each { |h| @json_array << h.to_json }
    @json_array
  end

  private

  def make_html
    doc = Nokogiri::HTML(URI.parse(URL).open)
    doc
  rescue StandardError => e
    puts "#{e.class} #{e.message}, Issue with connection"
  end

  def extract_books
    return unless make_html

    books = make_html.css('div.info-wrap')
    books.each do |book|
      hash = {
        title: book.css('a.title').text,
        author: book.css('a.text-gold').text,
        old_price: book.css('span.price-rrp').text,
        new_price: book.css('span.price').text
      }
      @list_of_books << hash
    end
    @list_of_books
  end
end
