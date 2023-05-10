class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      render "new"
      flash[:alert] = "Invalid email or password"
    end
  end

  def destroy
    session.destroy
    
    redirect_to root_path, notice: "Logout efetuado com sucesso."
  end
end