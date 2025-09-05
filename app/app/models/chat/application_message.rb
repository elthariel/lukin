# frozen_string_literal: true

class Chat::ApplicationMessage
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serializers::JSON
  extend ActiveModel::Callbacks
  # include ActiveModel::Validations::Callbacks

  attribute :type, :string, default: nil
  attribute :profile_id, :string, default: nil
  attribute :idx, :integer, default: nil
  attribute :sent_at, :datetime, default: nil

  validates :idx, presence: true
  validates :sent_at, presence: true
  validates :profile_id, presence: true
  validates :type, presence: true

  define_model_callbacks :create

  class << self
    def from(thing)
      if thing.is_a? self
        thing.deep_dup
      elsif thing.is_a? ActionController::Parameters
        from_params thing
      elsif thing.is_a? String
        from_json thing
      else
        from_hash thing
      end
    end

    def from_params(params)
      from_hash params.to_hash
    end

    def from_json(json)
      hash = JSON.parse(json)
      from_hash hash
    end

    def from_hash(hash)
      hash = hash.deep_symbolize_keys
      type = hash.delete :type
      klass = "Chat::#{type.camelize}Message".constantize
      klass.new(**hash)
    end
  end

  def initialize(...)
    run_callbacks :create do
      super
      self.type = self.class.name.demodulize.remove('Message').downcase
    end
  end

  def from?(profile)
    profile.id == profile_id
  end
end
