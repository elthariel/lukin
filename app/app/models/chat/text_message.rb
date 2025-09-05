# frozen_string_literal: true

class Chat::TextMessage < Chat::ApplicationMessage
  attr_accessor :text

  validates :text, presence: true, length: { minimum: 1, maximum: 500 }

  def attributes
    super.merge text:
  end
end
