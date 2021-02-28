class PlayerSerializer

  def initialize(player_obj)
    @player = player_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :name, :position, :jersey_num, :status],
      methods: [:stats]
    }
    @player.to_json(options)
  end

end