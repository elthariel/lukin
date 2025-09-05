# frozen_string_literal: true

module Chat::Messages
  extend ActiveSupport::Concern

  HISTORY_LIMIT = 1111
  HISTORY_CLEANUP = 1221

  included do
    before_validation :limit_messages_history
  end

  class_methods do
    def message
      Chat::ApplicationMessage
    end
  end

  def limit_messages_history
    return if messages.count < HISTORY_CLEANUP

    self.messages = messages[(-HISTORY_LIMIT..-1)]
  end

  def messages_raw
    self[:messages]
  end

  def messages
    super.map { |item| Chat::ApplicationMessage.from_hash item }
  end

  def add_message(msg)
    msg = self.class.message.from msg

    msg.idx = messages_raw.count
    msg.sent_at = DateTime.current

    errors.merge! msg.errors unless msg.valid?
    messages_raw.append(msg.attributes)

    msg
  end

  def clear_messages
    self.messages = []
  end

  def clear_messages!
    clear_messages
    save!
  end
end
