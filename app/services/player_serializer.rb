class PlayerSerializer

  def initialize(player_obj, other_obj=nil)
    @player = player_obj
    @other = other_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :name, :position, :jersey_num, :status],
      methods: [:stats]
    }
    @player.to_json(options)
  end

  def game_player_to_serialized_json
    options = {
      only: [:id, :name, :position, :jersey_num],
      game_stats: @other,
      include: {
        user: {
          only: [:id]
        }
      }
    }
    @player.to_json(options)
  end

  def game_player_as_json
    options = {
      only: [:id, :name, :position, :jersey_num],
      game_stats: @other,
      include: {
        user: {
          only: [:id]
        }
      }
    }
    @player.as_json(options)
  end

  def roster_as_json
    options = {
      only: [:id, :name, :position]
    }
    @player.as_json(options)
  end

  def aggregate_stats_as_json
    options = {
      only: [:id, :name, :position, :jersey_num],
      season_stats: @other
    }
    @player.as_json(options)
  end

end