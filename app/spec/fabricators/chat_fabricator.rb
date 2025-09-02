# == Schema Information
#
# Table name: chats
#
#  id         :uuid             not null, primary key
#  messages   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
Fabricator(:chat) do
  messages ""
end
