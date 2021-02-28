class TeamsController < ApplicationController

  def index
    teams = @current_user.teams
    render json: TeamSerializer.new(teams).index_to_serialized_json
  end

  def show
    team = Team.find_by(id: params[:id])
    if exists_and_teammate?(team)
      render json: TeamSerializer.new(team).show_to_serialized_json
    end
  end

  def create
    team = @current_user.teams_owned.build(team_params)
    team.players.build(user: @current_user, name: @current_user.name)
    if team.save
      render json: TeamSerializer.new(team).index_to_serialized_json
    else
      render json: {error: team.errors.full_messages}, status: :bad_request
    end
  end

  def update
    team = Team.find_by(id: params[:id])
    if exists_and_owner?(team)
      if team.update(team_params)
        render json: TeamSerializer.new(team).index_to_serialized_json
      else
        render json: {error: team.errors.full_messages}, status: :bad_request
      end
    end
  end

  def destroy
    team = Team.find_by(id: params[:id])
    if exists_and_owner?(team)
      team.destroy
      render json: { message: "Team Deleted!" }
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

end