class TeamSerializer

  def initialize(team_obj)
    @team = team_obj
  end

  def index_to_serialized_json
    options = {
      include: {
        owner: {
          only: [:id, :name]
        }
      },
      only: [:id, :name],
      methods: [:current_season_name, :current_record, :next_game, :last_game]
    }
    @team.to_json(options)
  end


end