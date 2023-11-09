class ApplicationController < ActionController::Base
  def hello
    render plain: "Hello, Mostafa"
  end
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end



  def show
      @user = User.find(params[:id])
  end

end
