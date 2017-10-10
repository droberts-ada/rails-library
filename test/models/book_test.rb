require "test_helper"

describe Book do
  let :author { Author.create! }
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
  end

  describe "relations" do
  end

  describe "age" do
  end
end
