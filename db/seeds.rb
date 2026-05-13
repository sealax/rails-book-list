require "open-uri"
require "json"

puts "Cleaining database..."

Bookmark.destroy_all
Book.destroy_all
List.destroy_all

puts "Fetching sci-fi books..."

url = "https://openlibrary.org/search.json?q=science+fiction&limit=20"

serialized_books = URI.open(url).read
books = JSON.parse(serialized_books)

books["docs"].each do |book_data|
  next if book_data["title"].nil?
  next if book_data["author_name"].nil?
  next if book_data["cover_i"].nil?

  Book.create!(
    title: book_data["title"],
    author: book_data["author_name"].first,
    description: "First published in #{book_data["first_publish_year"]|| "unknown year"}",
    cover_url: "https://covers.lopenlibrary.org/b/id/#{book_data["cover_i"]}-L.jpg"
  )
end

puts "#{Book.count} sci-fi books created!"

puts "Creating lists..."

List.create!(name: "Space Operas")
List.create!(name: "Cyberpunk")
List.create!(name: "AI and Robots")
List.create!(name: "Classics")

puts "Done!"
