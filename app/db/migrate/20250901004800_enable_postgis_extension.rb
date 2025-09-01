# frozen_string_literal: true

class EnablePostGISExtension < ActiveRecord::Migration[8.0]
  def up
    # Enable PostGIS extension in PostgreSQL
    enable_extension 'postgis'
  end

  def down
    # Remove PostGIS extension from PostgreSQL
    disable_extension 'postgis'
  end
end
