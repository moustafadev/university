class ApplicationController < ActionController::Base
  def hello
    render plain: "Hello, Mostafa"
  end
end
