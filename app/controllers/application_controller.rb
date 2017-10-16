class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

protected
  def require_login
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that!"
      redirect_to root_path
    end
  end

  def save_and_flash(model)
    result = model.save

    if result
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.class}"
      flash.now[:details] = model.errors.messages
    end

    return result
  end
end
