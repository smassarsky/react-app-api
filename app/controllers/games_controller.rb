class GamesController < ApplicationController

  def index
  end

  def show
    game = Game.find_by(id: params[:id])
    if exists_and_teammate?(game.team)
      render json: GameSerializer.new(game, @current_user).show_to_serialized_json
    end
  end

  def create
    season = Season.find_by(id: params[:game][:season_id])
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

  def add_player
    game = Game.find_by(id: params[:game_id])
    player = Player.find_by(id: params[:player_id])
    if game && player && game.team == player.team
      if @current_user == game.owner
        game.players << player
      elsif game.status == "TBP" && @current_user == player.user
        game.players << player
      else
        render json: { error: 'Invalid Request' }, status: :bad_request
      end
      if game.errors.messages.length == 0
        render json: PlayerSerializer.new(player, game).game_player_to_serialized_json
      else
        render json: { error: game.errors.full_messages }, status: :bad_request
      end
    else
      render json: { error: 'Invalid Request' }, status: :bad_request
    end
  end

  def remove_player
    game = Game.find_by(id: params[:game_id])
    player = Player.find_by(id: params[:player_id])
    if game && player && game.team == player.team
      if @current_user == game.owner
        game.players.destroy(player)
      elsif game.status == "TBP" && @current_user == player.user
        game.players.destroy(player)
      else
        render json: { error: 'Invalid Request' }, status: :bad_request
      end
      if game.errors.messages.length == 0
        render json: { success: "Player Removed" }
      else
        render json: { error: game.errors.full_messages }, status: :bad_request
      end
    else
      render json: { error: 'Invalid Request' }, status: :bad_request
    end
  end

  private

  def game_params
    params.require(:game).permit(:season_id, :opponent, :status, :win_loss, :place, :datetime)
  end

end