class NullifyGenderToUser < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :gender, true
  end
end
