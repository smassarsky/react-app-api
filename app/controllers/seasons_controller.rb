class SeasonsController < ApplicationController

  def index
  end

  def show
  end

  def create
    team = Team.find_by(id: params[:season][:team_id])
    if exists_and_owner?(team)
      season = Season.new(season_params)
      if season.save
        render json: SeasonSerializer.new(season).to_serialized_json
      else
        render json: { error: season.errors.full_messages }, status: :bad_request
      end
    end
  end

  def update
    season = Season.find_by(id: params[:id])
    if exists_and_owner?(season)
      if season.update(season_params)
        render json: SeasonSerializer.new(season).to_serialized_json
      else
        render json: { error: season.errors.full_messages }, status: :bad_request
      end
    end
  end

  def destroy
    season = Season.find_by(id: params[:id])
    if exists_and_owner?(season)
      season.destroy
      render json: { message: "Season Deleted"}
    end
  end

  private

  def season_params
    params.require(:season).permit(:name, :current, :team_id)
  end

end