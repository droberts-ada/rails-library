class BooksController < ApplicationController
  def index
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      if author
        @books = author.books
      else
        head :not_found
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
      render :new, status: :bad_request
    end
  end

  def show
    find_book_by_params_id
  end

  def edit
    find_book_by_params_id
  end

  def update
    if find_book_by_params_id
      @book.update_attributes(book_params)
      if @book.save
        redirect_to book_path(@book)
      else
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    if find_book_by_params_id
      @book.destroy
      redirect_to books_path
    end
  end

private
  def book_params
    return params.require(:book).permit(:title, :author_id, :publication_year)
  end

  def find_book_by_params_id
    @book = Book.find_by(id: params[:id])
    unless @book
      head :not_found
    end
    return @book
  end
end
