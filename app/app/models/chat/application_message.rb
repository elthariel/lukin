# frozen_string_literal: true

class Chat::ApplicationMessage
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serializers::JSON
  extend ActiveModel::Callbacks
  # include ActiveModel::Validations::Callbacks

  attribute :type, :string, default: nil
  attribute :user_id, :string, default: nil
  attribute :idx, :integer, default: nil
  attribute :sent_at, :datetime, default: nil

  validates :idx, presence: true
  validates :sent_at, presence: true
  validates :user_id, presence: true
  validates :type, presence: true

  define_model_callbacks :create

  def initialize(...)
    run_callbacks :create do
      super
      self.type = self.class.name.demodulize.remove('Message').downcase
    end
  end

  def self.from_hash(hash)
    hash = hash.deep_symbolize_keys
    type = hash.delete :type
    klass = "Chat::#{type.camelize}Message".constantize
    klass.new(**hash)
  end

  def self.from_json(json)
    hash = JSON.parse(json)
    from_hash hash
  end

  def from?(user)
    user.id == user_id
  end
end
