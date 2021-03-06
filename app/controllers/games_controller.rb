class GamesController < ApplicationController

  def index
  end

  def show
    game = Game.find_by(id: params[:id])
    if exists_and_teammate?(game.team)
      render json: GameSerializer.new(game).show_to_serialized_json
    end
  end

  def create
    season = Season.find_by(id: params[:game][:season_id])
    byebug
    if exists_and_owner?(season)
      game = Game.new(game_params)
      if game.save
        render json: GameSerializer.new(game).to_serialized_json
      else
        render json: { error: game.errors.full_messages }, status: :bad_request
      end
    end
  end

  def update
    game = Game.find_by(id: params[:id])
    if exists_and_owner?(game)
      if game.update(game_params)
        render json: GameSerializer.new(game).to_serialized_json
      else
        render json: { error: game.errors.full_messages }, status: :bad_request
      end
    end
  end

  def destroy
    game = Game.find_by(id: params[:id])
    if exists_and_owner?(game)
      game.destroy
      render json: { message: "Game Deleted" }
    end
  end

  private

  def game_params
    params.require(:game).permit(:season_id, :opponent, :status, :win_loss, :place, :datetime)
  end

end