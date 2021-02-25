class TeamsController < ApplicationController

  def index
    teams = @current_user.teams
    puts @current_user
    render json: TeamSerializer.new(teams).index_to_serialized_json
  end

  def show
  end

  def update
  end

  def destroy
  end

end