#!/usr/bin/env ruby
# frozen_string_literal:true

require_relative '../lib/books_scraper'

def scrape_books
     books_scraper = Books.new

     puts "Input a name for your file with the Books Scraper."

     name = gets.chomp

     json_array = books_scraper.get_top_books

     if json_array
      File.open("#{name}.txt",'w+') do |file|
        json_array.each {|book| file.puts(book)}
     end
       puts "Your file, #{name}.txt has been made"
    end
   end

   scrape_books

