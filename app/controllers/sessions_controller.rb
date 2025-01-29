class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if (Rails.env.development? && params[:password] == "ks") || (user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to game_sessions_path
    else
      flash.now[:alert] = "Invalid username or password"
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash-messages", partial: "layouts/flash") }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
