class PlayerSerializer

  def initialize(player_obj, game_obj=nil)
    @player = player_obj
    @game = game_obj
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
      game_stats: @game,
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
      game_stats: @game,
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

end