class AuthorsController < ApplicationController
  def index
    @authors = Author.all.order(:nationality, :name)
  end

  def new
  end

  def create
  end

  def login_form
  end

  def login
    name = params[:author][:name]

    # Double check that this author exists
    author = Author.find_by(name: name)
    if author
      session[:logged_in_author] = author.id
      redirect_to books_path
    else
      flash[:status] = :failure
      flash[:message] = "No author found with name #{name}"
      render :login_form
    end
  end
end
