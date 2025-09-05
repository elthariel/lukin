# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include Ransackable

  def self.human_enum_name(field, value)
    I18n.t("activerecord.attributes.#{name.underscore}.#{field}.#{value}",
           default: value.to_s.camelize)
  end
end
