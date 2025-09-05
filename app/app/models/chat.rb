# == Schema Information
#
# Table name: chats
#
#  id         :uuid             not null, primary key
#  messages   :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chat < ApplicationRecord
  include Chat::Messages

  has_many :chat_links
  has_many :profiles, through: :chat_links

  class << self
    def between_scope(profile, other_profile)
      ChatLink.where(profile: , other_profile:)
    end

    def between(...)
      between_scope(...).first&.chat
    end

    def between?(...)
      between_scope(...).exists?
    end

    def create_between!(profile, other_profile, **kw)
      # XXX: Add error handling here..
      self.transaction do
        chat = Chat.create!(**kw)
        ChatLink.create!(profile:, other_profile:, chat:)
        ChatLink.create!(profile: other_profile, other_profile: profile, chat:)

        chat
      end
    end

    def find_or_create_between!(profile, other_profile, **kw)
      between(profile, other_profile) || create_between!(profile, other_profile, **kw)
    end
  end

  # Get the other profile in the chat for the current user
  def other_profile_for(current_profile)
    profiles.where.not(id: current_profile.id).first
  end
end
