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

  def format_attr_height(value)
    "#{value / 100.0} m"
  end

  def format_attr_weight(value)
    "#{value} kg"
  end

  def format_attr_position(value)
    Profile.human_enum_name(:position, value)
  end

  def format_attr_body(value)
    Profile.human_enum_name(:body, value)
  end

  def format_attr_gender(value)
    Profile.human_enum_name(:gender, value)
  end

  def format_attr_relationship(value)
    Profile.human_enum_name(:relationship, value)
  end
end
