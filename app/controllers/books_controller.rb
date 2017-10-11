class BooksController < ApplicationController
  def index
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      if author
        @books = author.books
      else
        render status: :not_found, file: "#{Rails.root}/public/404.html"
      end
    else
      @books = Book.all
    end
  end

  # Add in another comment

  def new #Only cares about showing the form
    @book = Book.new
    if params[:author_id]
      @book.author_id = params[:author_id]
    end
  end

  def create #Has access to user data, from the form
    # Before, using a hand-rolled form, the format of data coming off
    # the wire was different, so the way we pulled it out was also different:
    # book = Book.new(title: params[:title], author: params[:author])

    # @book = Book.new(params[:book]) # Rails will throw an error because this is insecure
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path
    else
      # Tell the user what went wrong
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
    # @book = Book.find_by(title: params[:book_id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    # Always use destroy! Delete will create weird bugs for you.
    # @book.delete
    @book.destroy
    redirect_to books_path
  end

private
  def book_params
    return params.require(:book).permit(:title, :author_id, :publication_year)
  end
end
