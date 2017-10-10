# app/models/book.rb
class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :genres

  validates :title, presence: true, uniqueness: { message: "The title was not unique! Please choose a different one" }
  validates :description, length: { maximum: 500, message: "The description is too long" }

  # comments here too
  def age
    if publication_year
      return Date.today.year - publication_year
    else
      return "unknown"
    end
  end

end
