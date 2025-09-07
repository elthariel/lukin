module UnitComponent
  class Render
    include ActionView::Helpers::TagHelper
  end

  def has_unit?
     options[:unit]
  end

  def unit(_wrapper_options = nil)
    # rubocop:disable Rails/OutputSafety
    @unit ||= options[:unit].html_safe if has_unit?
    # rubocop:enable all
  end
end

SimpleForm.include_component(UnitComponent)
