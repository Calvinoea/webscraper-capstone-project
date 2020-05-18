# frozen_string_literal:true

require 'nokogiri'
require 'open-uri'
require 'json'

class Books # :nodoc:
  URL = 'https://www.waterstones.com/campaign/books-of-the-month'

      def initialize
        @list_of_books = []
        @json_array = []
      end

      def get_top_books
        hash = extract_books
        if hash
          hash.each {|h| @json_array << h.to_json}
          @json_array
        end
      end

      private

      def make_html
        begin
          doc = Nokogiri::HTML(URI.parse(URL).open)
          doc
        rescue => error
          puts "#{error.class} #{error.message}, Issue with connection"
        end
      end

      def extract_books
        if make_html
          books = make_html.css('div.info-wrap')
          books.each do |book|
            hash = {
            title: book.css('a.title').text,
            author:book.css('a.text-gold').text,
            old_price:book.css('span.price-rrp').text,
            new_price:book.css('span.price').text
            }
            @list_of_books << hash
          end
          @list_of_books
        end
      end
    end
