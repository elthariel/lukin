# frozen_string_literal: true

module PublishedAt
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(published_at: ..DateTime.current) }
  end

  def publish
    self.published_at = DateTime.current
  end

  def publish!
    publish
    save!
  end

  def published?
    published_at.present? && published_at <= DateTime.current
  end

  def published_at=(value)
    if value.blank? || value == '0'
      value = nil
    elsif value == '1' || value.is_a?(TrueClass)
      value = DateTime.current
    end

    super
  end
end
