# frozen_string_literal: true

module ApplicationHelper
  def notice_level_to_class(level)
    case level.to_sym
    when :notice
      'bg-slate-800 border-blue-500'
    when :alert
      'bg-slate-800 border-yellow-500'
    when :error
      'bg-slate-800 border-red-500'
    else
      'bg-slate-800 border-slate-600'
    end
  end

  def notice_level_to_icon(level)
    case level.to_sym
    when :notice
      'check'
    when :alert
      'info'
    when :error
      'circle-alert'
    else
      'help-circle'
    end
  end

  # rubocop:disable Rails/OutputSafety
  def markdown!(content)
    return '' if content.blank?

    Commonmarker.to_html(
      content,
      options: {
        parse: { smart: true },
        render: { hardbreaks: false }
      }
    ).html_safe
  end

  def mustache(content, **kw)
    return '' if content.blank?

    Mustache.render(content, **kw)
  end
  # rubocop:enable all
end
