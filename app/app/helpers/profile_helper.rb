# frozen_string_literal: true

module ProfileHelper
  def format_distance(distance)
    return if distance.blank?

    if distance < 1000
      meters = distance.round(-2)
      "~#{ meters } m"
    else
      km = (distance / 1000.0)
      if km > 10
        km = km.round
      else
        km = km.round(1)
      end
      "#{km} km"
    end
  end
end
