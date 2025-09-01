# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, null: false, index: true
      t.st_point :location, geographic: true, has_z: false
      t.integer :age
      t.jsonb :data, null: false, default: {}

      t.timestamps

      t.index :location, using: :gist
      t.index %i[updated_at age]
    end
  end
end
