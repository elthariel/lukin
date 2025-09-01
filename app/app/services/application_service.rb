# frozen_string_literal: true

class ApplicationService
  def self.call(...)
    new(...).call
  end

  def errors_model
    self
  end

  def self.human_attribute_name(name, _options = {})
    name.camelize
  end

  def errors
    @errors ||= ActiveModel::Errors.new(errors_model)
  end

  def call
    raise NotImplementedError("Implement #call in #{self.class}")
  end
end
