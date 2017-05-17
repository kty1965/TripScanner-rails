class AddInfomationsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string, null: false
    add_column :users, :mobile_number, :string
    add_column :users, :locale, :string, null: false, default: "ko"
    add_column :users, :country, :string, null: false, default: "kr"
    add_column :users, :introduction, :text
    add_column :users, :school, :string
    add_column :users, :job, :string
  end
end
