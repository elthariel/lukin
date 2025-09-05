# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats, id: :uuid do |t|
      t.jsonb :messages, null: false, default: []

      t.timestamps
    end
  end
end
