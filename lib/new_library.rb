require "new_library/book"
require "new_library/reader"
require "new_library/author"
require "new_library/order"
require "new_library/version"

module NewLibrary
  

class Library

  def initialize(book, reader, order)
    @author   = []
    @book     = []
    @reader   = []
    @order    = []
  end

  def save_file(filename)
    File.open('filename', 'a') {|f| f.write(Marshal.dump(self)) }
  end

  def read_file(filename)
    Marshal.load(File.read(filename))
  end

  def most_popular_book
    book = Hash.new()
    book = @book.max_by{|reader| reader.count}
    return book.first
  end

  def who_often_takes_the_book 
    orders = self.orders.select { |order| order.book == book }
    cnt(orders.map { |order| order.reader }).max_by { |key, value| value }
  end

  def three_popular_books
    books = self.orders.map { |order| order.book }
    cnt(books).sort_by { |key, value| value }.reverse[0..2]
  end


    private

  def cnt(items)
    items.inject(Hash.new{ 0 }) { |memo, item| memo[item] += 1; memo }
  end

end


end
