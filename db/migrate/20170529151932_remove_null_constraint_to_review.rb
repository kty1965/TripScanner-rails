class RemoveNullConstraintToReview < ActiveRecord::Migration[5.0]
  def change
    change_column_null :reviews, :rate, true
  end
end
