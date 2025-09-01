# frozen_string_literal: true

module LucideIconComponent
  class Render
    include ActionView::Helpers::TagHelper
    include LucideRails::RailsHelper
  end

  # To avoid deprecation warning, you need to make the wrapper_options explicit
  # even when they won't be used.
  def lucide_icon(_wrapper_options = nil)
    # rubocop:disable Rails/OutputSafety
    @lucide_icon ||= (Render.new.lucide_icon(options[:lucide_icon]).html_safe if options[:lucide_icon].present?)
    # rubocop:enable all
  end
end

SimpleForm.include_component(LucideIconComponent)
