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
class Profile < ApplicationRecord
  belongs_to :user, optional: false

  jsonb_accessor :data,
                 title: [:string, { default: '' }],
                 bio: [:string, { default: '' }]

  scope :with_distance, lambda { |point|
    select('*', arel_table[:location].st_distance(Arel.spatial(point)).as('distance'))
  }
  scope :by_distance, ->(point) { with_distance(point).order(distance: :asc) }

  validates :age, numericality: { greater_than_or_equal_to: 18 }

  def self.location_factory
    # Longitude, Latitude
    @location_factory ||= RGeo::Geographic.spherical_factory(srid: 4326)
  end
end
