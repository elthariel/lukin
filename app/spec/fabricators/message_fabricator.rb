# frozen_string_literal: true

Fabricator :text_message, class_name: 'Chat::TextMessage' do
  type :text
  idx 0
  sent_at { DateTime.current }
  user_id { 'user_id' }
  text { FFaker::LoremFR.sentences(rand(1..3)).join ' ' }
end
