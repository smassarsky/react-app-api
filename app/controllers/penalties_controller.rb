class PenaltiesController < ApplicationController

  def create
    game = Game.find_by(id: params[:penalty][:game_id])
    if exists_and_owner?(game)
      penalty = Penalty.new(penalty_params)
      if penalty.save
        render json: PenaltySerializer.new(penalty).to_serialized_json
      else
        render json: { error: penalty.errors.full_messages }
      end
    end
  end

  def update
    penalty = Penalty.find_by(id: params[:id)
    if exists_and_owner?(penalty)
      if penalty.update(penalty_params)
        render json: PenaltySerializer.new(penalty).to_serialized_json
      else
        render json: { error: penalty.errors.full_messages }
      end
    end
  end

  def destroy
    penalty = Penalty.find_by(id: params[:id])
    if exists_and_owner?(penalty)
      penalty.destroy
      render json: { success: "Penalty Deleted" }
    end
  end

  private

  def penalty_params
    params.require(:penalty).permit(:game_id, :player_id, :team_id, :period, :time, :length, :infraction)
  end

end