class CreateTripMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :trip_members do |t|
      t.references :trip, index: true, null: false, foreign_key: { to_table: :trips }
      t.references :member, index: true, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end

    add_index :trip_members, [:trip_id, :member_id], :unique => true
  end
end
