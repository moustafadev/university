class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Successfully logged in, handle the logic here
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy

  end
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
