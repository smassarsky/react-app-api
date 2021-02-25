class TeamSerializer

  def initialize(team_obj)
    @team = team_obj
  end

  def index_to_serialized_json
    options = {
      only: [:id, :name, :owner_name, :current_season, :current_record, :next_game, :last_game]
    }
    @team.to_json(options)
  end

end