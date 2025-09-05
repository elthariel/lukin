# frozen_string_literal: true

module MessageHelper
  def message_classes_for(me)
    if me
      {
        align: 'justify-end text-right',
        bg: 'bg-gray-800',
        fg: 'opacity-50',
        rounded: 'rounded-br-none'
      }
    else
      {
        align: 'justify-start text-left',
        bg: 'bg-primary',
        fg: 'opacity-80',
        rounded: 'rounded-bl-none'
      }
    end
  end


end
