class BooksController < ApplicationController
  before_action :find_book_by_params_id, only: [:show, :edit, :update, :destroy]

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

    if save_and_flash(@book)
      redirect_to books_path
    else
      render :new, status: :bad_request
    end
  end

  def show ; end

  def edit ; end

  def update
    #if find_book_by_params_id
    @book.update_attributes(book_params)
    if save_and_flash(@book)
      redirect_to book_path(@book)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    current_author = nil
    if session[:logged_in_author]
      current_author = Author.find_by(id:session[:logged_in_author])

    # The following code is redundant
    # else
    #   flash[:status] = :failure
    #   flash[:message] = "You must be logged in to do that!"
    #   redirect_to books_path
    #   return
    end

    # if find_book_by_params_id
      if current_author != @book.author
        flash[:status] = :failure
        flash[:message] = "Only a book's author can destroy it!"
        redirect_to books_path
        return
      end

      @book.destroy
      flash[:status] = :success
      flash[:message] = "Deleted book #{@book.id}"
      redirect_to books_path
    # end
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
    # Don't need a return b/c we're no longer calling this directly
    # and if there's an error we won't even get into our controller action
    # return @book
  end
end
