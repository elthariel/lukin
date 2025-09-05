# frozen_string_literal: true

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
  ACTIVE = 30.minutes
  CONNECTED = 3.days

  belongs_to :user, optional: false
  has_many :chat_links
  has_many :chats, through: :chat_links

  jsonb_accessor :data,
    title: [:string, default: ''],
    bio: [:string, default: '']

  has_one_attached :picture do |pic|
    pic.variant :thumbnail, resize_to_fill: [500, 500]
  end

  scope :with_distance, lambda { |point|
    select('*', arel_table[:location].st_distance(Arel.spatial(point)).as('distance'))
  }
  scope :by_distance, ->(point) { with_distance(point).order(distance: :asc) }
  scope :connected, -> { where('updated_at > ?', CONNECTED.ago ) }

  validates :age, numericality: { greater_than_or_equal_to: 18 }
  validates :picture, blob: {
      content_type: ["image/png", "image/jpg", "image/jpeg", "image/webp"],
      size_range: 1..(8.megabytes)
    }

  def self.location_factory
    # Longitude, Latitude
    @location_factory ||= RGeo::Geographic.spherical_factory(srid: 4326)
  end

  # We assume the user is online/active if they updated their profile/location recently
  def active?
    updated_at > ACTIVE.ago
  end
end
