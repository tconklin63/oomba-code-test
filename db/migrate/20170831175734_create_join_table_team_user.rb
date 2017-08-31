class CreateJoinTableTeamUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :teams, :users do |t|
      t.index [:team_id, :user_id]
    end
  end
end
