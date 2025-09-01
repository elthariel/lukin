# == Schema Information
#
# Table name: profiles
#
#  id         :uuid             not null, primary key
#  age        :integer
#  data       :jsonb            not null
#  location   :geography        point, 4326
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_profiles_on_location            (location) USING gist
#  index_profiles_on_updated_at_and_age  (updated_at,age)
#  index_profiles_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FRANCE_BBOX = [[4.504395, 42.779275], [8.481445, 51.522416]]

Fabricator(:profile_base, class_name: 'Profile') do
  location do
    Profile.location_factory.point(
      *FFaker::Geolocation.boxed_coords(*FRANCE_BBOX)
    )
  end
  title     { FFaker::NameFR.first_name }
  bio       { FFaker::LoremFR.sentence }
  age       { rand(18..60) }
end

Fabricator(:profile, from: :profile_base) do
  user(fabricator: :user_base)
end
