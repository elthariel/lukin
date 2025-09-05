class AddAttributesToProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :height, :integer
    add_column :profiles, :weight, :integer
    add_column :profiles, :position, :integer, default: 0, null: false
    add_column :profiles, :body, :integer, default: 0, null: false
    add_column :profiles, :gender, :integer, default: 0, null: false
  end
end
