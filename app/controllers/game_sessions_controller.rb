class GameSessionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @game_sessions = current_user.game_sessions.order(updated_at: :desc)
    @game_session = GameSession.new
  end

  def create
    @game_session = current_user.game_sessions.build(game_session_params)
    if @game_session.save
      session[:last_game_session_id] = @game_session.id
      redirect_to scores_path(game_session_id: @game_session.id)
    else
      flash.now[:alert] = @game_session.errors.full_messages.join(", ")
      @game_sessions = current_user.game_sessions.order(updated_at: :desc).select(&:persisted?)
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @game_session = current_user.game_sessions.find(params[:id])
  end

  def update
    @game_session = current_user.game_sessions.find(params[:id])
    if @game_session.update(game_session_params)
      redirect_to game_session_path(@game_session), notice: t("game_sessions.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @game_session = current_user.game_sessions.find(params[:id])
    @game_session.destroy
    redirect_to game_sessions_path, status: :see_other
  end

  private

  def game_session_params
    params.require(:game_session).permit(:name1, :name2, :name3, :name4)
  end
end
