class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :writer, index: true, foreign_key: { to_table: :users }, null: false
      t.references :owner, index: true, foreign_key: { to_table: :users }, null: false
      t.string :scope, null: false
      t.float :rate, null: false
      t.text :content
      t.references :trip, index: true
      t.timestamps
    end
  end
end
