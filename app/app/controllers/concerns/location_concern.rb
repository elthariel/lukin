# frozen_string_literal: true

module LocationConcern
  def current_location
    # Debug in Paris
    Profile.location_factory.point(2.3372222, 48.88069086118401)
  end
end
