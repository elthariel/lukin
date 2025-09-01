# frozen_string_literal: true

module MobilityHelper
  module_function

  def fields(*names)
    if names.length == 1 && names.first.respond_to?(:mobility_attributes)
      names = names.first.mobility_attributes.map(&:to_sym)
    end

    names.map do |name|
      I18n.available_locales.map do |locale|
        :"#{name}_#{locale}"
      end
    end.flatten
  end

  def each_field(*names, &)
    fields(*names).each(&)
  end

  def fields_by_locale(*fields)
    result = {}

    I18n.available_locales.each do |locale|
      localized_fields = fields.map { |name| [name, locale].join('_').to_sym }
      yield locale, localized_fields if block_given?
      result[locale] = localized_fields
    end

    result
  end
end
