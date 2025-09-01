# frozen_string_literal: true

module Ransackable
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :ransack_attrs_denylist, :ransack_assocs_denylist

    def ransack_attrs_deny(*attrs)
      @ransack_attrs_denylist ||= []
      @ransack_attrs_denylist.push(*attrs.map(&:to_s))
    end

    def ransack_assocs_deny(*assocs)
      @ransack_assocs_denylist ||= []
      @ransack_assocs_denylist.push(*assocs.map(&:to_s))
    end

    def ransackable_associations(_auth_object = nil)
      @ransackable_associations ||=
        reflect_on_all_associations.map { |a| a.name.to_s } -
        (@ransack_assocs_denylist || [])
    end

    def ransackable_attributes(_auth_object = nil)
      @ransackable_attributes ||=
        column_names + _ransackers.keys +
        _ransack_aliases.keys + attribute_aliases.keys -
        (@ransack_attrs_denylist || [])
    end
  end
end
