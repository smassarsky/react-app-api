class CreateBackendTables < ActiveRecord::Migration[6.0]
  def change

    create_table :teams do |t|
      t.integer :owner_id
      t.integer :current_season_id
      t.string :name

      t.timestamps
    end

    create_table :players do |t|
      t.integer :user_id
      t.integer :team_id
      t.string :name
      t.string :position
      t.integer :jersey_num
      t.string :status

      t.timestamps
    end

    create_table :player_codes do |t|
      t.integer :player_id
      t.string :code
      t.string :status

      t.timestamps
    end

    create_table :seasons do |t|
      t.integer :team_id
      t.string :name

      t.timestamps
    end

    create_table :games do |t|
      t.integer :season_id
      t.string :opponent
      t.string :status
      t.string :win_loss
      t.string :place
      t.datetime :datetime

      t.timestamps
    end

    create_table :game_players do |t|
      t.integer :game_id
      t.integer :player_id

      t.timestamps
    end

    create_table :penalties do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :team_id
      t.integer :period
      t.string :time
      t.integer :length
      t.string :infraction

      t.timestamps
    end

    create_table :goals do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :team_id
      t.integer :period
      t.string :time

      t.timestamps
    end

    create_table :assists do |t|
      t.integer :goal_id
      t.integer :player_id

      t.timestamps
    end

    create_table :on_ice do |t|
      t.integer :goal_id
      t.integer :player_id

      t.timestamps
    end

  end
end
