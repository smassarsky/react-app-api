class SeasonSerializer

  def initialize(season_obj)
    @season = season_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :name],
      methods: [:current, :record, :next_game, :last_game]
    }
    @season.to_json(options)
  end

  def show_to_serialized_json
    options = {
      only: [:id, :name],
      include: {
        team: {
          only: [:id, :name, :owner_id]
        },
        games: {
          only: [:id, :opponent, :datetime, :place, :win_loss, :status]
        },
        players: {
          only: [:id, :name, :position, :jersey_num, :status],
          stats: @season
        }
      }
    }
    @season.to_json(options)
  end

end