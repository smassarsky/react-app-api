class TeamSerializer

  def initialize(team_obj, user_obj = nil)
    @team = team_obj
    @user = user_obj
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

  def show_to_serialized_json
    options = {
      include: {
        owner: {
          only: [:id, :name]
        },
        seasons: {
          only: [:id, :name],
          methods: [:current, :record, :next_game, :last_game]
        },
        players: {
          only: [:id, :name, :position, :jersey_num, :status],
          methods: [:stats],
          include: {
            user: {
              only: [:id, :name]
            }
          }
        }
      }
    }
    if @user
      options[:include][:players][:include][:player_code] = { only: [:code] }
    end
    puts @user
    puts options
    @team.to_json(options)
  end

end