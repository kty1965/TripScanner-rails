class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.references :owner, index: true, null: false, foreign_key: { to_table: :users }
      t.string :address, null: false
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.timestamps
    end
  end
end
