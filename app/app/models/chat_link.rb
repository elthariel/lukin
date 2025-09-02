# == Schema Information
#
# Table name: chat_links
#
#  id               :uuid             not null, primary key
#  blocked          :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  chat_id          :uuid             not null
#  other_profile_id :uuid             not null
#  profile_id       :uuid             not null
#
# Indexes
#
#  index_chat_links_on_chat_id                 (chat_id)
#  index_chat_links_on_other_profile_id        (other_profile_id)
#  index_chat_links_on_profile_id_and_blocked  (profile_id,blocked)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (other_profile_id => profiles.id)
#  fk_rails_...  (profile_id => profiles.id)
#
class ChatLink < ApplicationRecord
  belongs_to :profile
  belongs_to :other_profile, class_name: 'Profile'
  belongs_to :chat
end
