# == Schema Information
#
# Table name: chats
#
#  id         :uuid             not null, primary key
#  messages   :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
Fabricator(:chat_base, class_name: 'Chat') do
  messages {[]}
end

Fabricator(:chat, from: :chat_base) do
  chat_links do
    link_0 = Fabricate.build(:chat_link_base)
    link_1 = Fabricate.build(
      :chat_link_base, profile: link_0.other_profile, other_profile: link_0.profile
    )

    [link_0, link_1]
  end
end
