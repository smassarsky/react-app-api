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

end