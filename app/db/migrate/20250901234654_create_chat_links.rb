# frozen_string_literal: true

class CreateChatLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_links, id: :uuid do |t|
      t.references :profile, null: false, type: :uuid, foreign_key: true, index: false
      t.references :other_profile, null: false, type: :uuid,
        foreign_key: { to_table: :profiles }, index: false
      t.references :chat, null: false, foreign_key: true, type: :uuid

      t.boolean :blocked, null: false, default: false

      t.timestamps

      t.index %i[profile_id blocked]
      t.index %i[profile_id other_profile_id], unique: true
    end
  end
end
