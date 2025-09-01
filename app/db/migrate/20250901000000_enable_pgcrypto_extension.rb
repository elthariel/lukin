# frozen_string_literal: true

class EnablePgcryptoExtension < ActiveRecord::Migration[8.0]
  def change
    enable_extension 'pgcrypto'
  end
end