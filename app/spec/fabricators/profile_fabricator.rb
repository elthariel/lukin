# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :uuid             not null, primary key
#  age        :integer
#  body       :integer          default("unknown"), not null
#  data       :jsonb            not null
#  gender     :integer          default("unknown"), not null
#  height     :integer
#  location   :geography        point, 4326
#  position   :integer          default("unknown"), not null
#  weight     :integer
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

FRANCE_BBOX = [[4.504395, 42.779275], [8.481445, 51.522416]].freeze

PICS = Rails.root.glob('spec/fixtures/sexy/*.jpg')

Fabricator(:profile_base, class_name: 'Profile') do
  location do
    Profile.location_factory.point(
      *FFaker::Geolocation.boxed_coords(*FRANCE_BBOX)
    )
  end
  title     { FFaker::NameFR.first_name }
  bio       { FFaker::LoremFR.sentence }
  picture   { File.open PICS.sample }

  age       { rand(18..60) }
  weight    { rand(50...120) }
  height    { rand(140...220) }
  position  { Profile.positions.keys.sample }
  body      { Profile.bodies.keys.sample }
  gender    { Profile.genders.keys.sample }

  hide_age       { [true, false].sample }
  hide_weight    { [true, false].sample }
  hide_height    { [true, false].sample }
  hide_position  { [true, false].sample }
  hide_body      { [true, false].sample }
  hide_gender    { [true, false].sample }
end

Fabricator(:profile, from: :profile_base) do
  user(fabricator: :user_base)
end
