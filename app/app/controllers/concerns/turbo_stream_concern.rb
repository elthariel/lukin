# frozen_string_literal: true

module TurboStreamConcern
  extend ActiveSupport::Concern

  def turbo = Turbo::StreamsChannel
end
