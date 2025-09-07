# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id           :uuid             not null, primary key
#  age          :integer
#  body         :integer          default("unknown"), not null
#  data         :jsonb            not null
#  gender       :integer          default("unknown"), not null
#  height       :integer
#  location     :geography        point, 4326
#  position     :integer          default("unknown"), not null
#  relationship :integer          default("unknown"), not null
#  weight       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
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

  has_one_attached :picture do |pic|
    pic.variant :thumbnail, resize_to_fill: [500, 500]
  end

  jsonb_accessor :data,
    title: [:string, default: ''],
    bio: [:string, default: ''],
    hide_distance: [:boolean, default: false],
    hide_age: [:boolean, default: false],
    hide_height: [:boolean, default: false],
    hide_weight: [:boolean, default: false]

  enum :position, {
      unknown: 0, soft: 1, top: 2, versatile_top: 3, versatile: 4,
      versatile_bottom: 5, bottom: 6,
    }, prefix: true
  enum :body, {
      unknown: 0, thin: 1, average: 2, toned: 3, muscular: 5, large: 6
    }, prefix: true
  enum :gender, {
      unknown: 0, other: 1, cis: 2, queer: 3, trans: 4, non_binary: 5, fluid: 6, nope: 7
    }, prefix: true
  enum :relationship, {
      unknown: 0, single: 1, couple: 2, free_couple: 3, married: 4, poly: 5
    }, prefix: true

  scope :with_distance, lambda { |point|
    select('*', arel_table[:location].st_distance(Arel.spatial(point)).as('distance'))
  }
  scope :by_distance, ->(point) { with_distance(point).order(distance: :asc) }
  scope :connected, -> { where('updated_at > ?', CONNECTED.ago ) }

  validates :age, numericality: { greater_than_or_equal_to: 18 }
  validates :height, numericality: { in: (50..260) }
  validates :weight, numericality: { in: (10..500) }

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

  def hide_nothing!
    update(
      hide_age: false,
      hide_position: false,
      hide_height: false,
      hide_weight: false,
      hide_body: false
    )
  end
end
