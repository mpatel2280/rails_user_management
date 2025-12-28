class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:email].blank? || params[:password].blank?
      flash.now[:alert] = "Email and password are required"
      render :new, status: :unprocessable_entity
      return
    end

    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Logged out"
  end
end
