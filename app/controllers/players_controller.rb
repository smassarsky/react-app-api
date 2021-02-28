class PlayersController < ApplicationController

  def show
    player = Player.find_by(id: params[:id])
    render json: PlayerSerializer.new(player).serialized_json
  end

  def create
    team = Team.find_by(id: params[:player][:team_id])
    if exists_and_owner?(team)
      player = Player.new(player_params)
      if player.save
        render json: PlayerSerializer.new(player).to_serialized_json
      else
        render json: { error: player.errors.full_messages }, status: :bad_request
      end
    end
  end

  def update
    player = Player.find_by(id: params[:id])
    if exists_and_owner?(player)
      if player.update(player_params)
        render json: PlayerSerializer.new(player).to_serialized_json
      else
        render json: { error: player.errors.full_messages }, status: :bad_request
      end
    end
  end

  def destroy
    player = Player.find_by(id: params[:id])
    if exists_and_owner?(player)
      if player.destroy
        render json: { message: "Player Deleted" }
      else
        render json: { error: player.errors.full_messages }, status: :bad_request
      end
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :position, :jersey_num, :status, :team_id)
  end
  
end