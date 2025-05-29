class ScoresController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:game_session_id].present?
      session[:last_game_session_id] = params[:game_session_id]
    end

    if session[:last_game_session_id].present?
      @game_session = current_user.game_sessions.find_by(id: session[:last_game_session_id])
    else
      @game_session = nil
    end
  end
end
