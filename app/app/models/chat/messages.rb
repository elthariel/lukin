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
    if msg.is_a? String
      msg = ApplicationMessage.from_json(msg)
    else
      msg = msg.clone
    end

    # This is likely a lot of extra object for nothing :sob:
    msg = msg.deep_dup
    msg.idx = messages_raw.count
    msg.sent_at = DateTime.current

    if msg.valid?
      messages_raw.append(msg.attributes)
      true
    else
      errors.merge! msg.errors
      false
    end
  end

  def clear_messages
    self.messages = []
  end

  def clear_messages!
    clear_messages
    save!
  end
end
