require "test_helper"

describe BooksController do
  describe "index" do
    it "returns a success status for all books" do
      get books_path
      must_respond_with :success
    end

    it "returns a success status when there are no books" do
      Book.destroy_all
      get books_path
      must_respond_with :success
    end

    it "returns a success status when given a valid author_id" do
      get author_books_path(Author.first)
      must_respond_with :success
    end

    it "returns something when given a bogus author_id" do
      bad_author_id = Author.last.id + 1
      get author_books_path(bad_author_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
  end

  describe "create" do
    it "does something when the book data is valid" do
      # Arrange
      book_data = {
        book: {
          title: "Test book",
          author_id: Author.first.id
        }
      }
      # Test data should result in a valid book, otherwise
      # the test is broken
      Book.new(book_data[:book]).must_be :valid?

      start_book_count = Book.count

      # Act
      post books_path, params: book_data

      # Assert
      must_respond_with :redirect
      must_redirect_to books_path

      Book.count.must_equal start_book_count + 1
    end

    it "does something when the book data is bogus" do
      # Arrange
      # Act
      # Assert
    end
  end

  describe "show" do
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "destroy" do
  end
end
