require "test_helper"

describe Book do
  let :author { Author.first }
  describe "validations" do
    it "can be created with all fields" do
      b = Book.new(author: author, title: "test book")

      b.must_be :valid?
    end

    it "requires a title" do
      b = Book.new
      is_valid = b.valid?
      is_valid.must_equal false
      b.errors.messages.must_include :title
    end

    it "requires a unique title" do
      title = "test book"
      b1 = Book.create!(title: title, author: author)
      b2 = Book.new(title: title, author: author)

      b2.wont_be :valid?
    end

    describe "description" do
      it "rejects descriptions longer than 500 chars" do
        desc = "a" * 501
        b = Book.new(description: desc)

        # b.wont_be :valid?
        is_valid = b.valid?
        is_valid.must_equal false

        b.errors.messages.must_include :description
      end

      it "allows descriptions <= 500 chars" do
        descriptions = [
          "a" * 500,
          "a" * 10,
          "a" * 0
        ]

        descriptions.each do |desc|
          b = Book.new(title: "test", author: author, description: desc)

          b.must_be :valid?
        end
      end
    end

  end

  describe "relations" do
    it "has an author" do
      b = books(:poodr)
      a = authors(:metz)

      b.must_respond_to :author
      b.author.must_equal a
      b.author_id.must_equal a.id
    end

    it "has a collection of genres" do
      b = Book.new
      b.must_respond_to :genres
      b.genres.must_be :empty?

      g = Genre.create!(name: "test genre")
      b.genres << g
      b.genres.must_include g
    end
  end

  describe "age" do
  end
end
