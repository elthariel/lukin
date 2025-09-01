# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :uuid             not null, primary key
#  age        :integer
#  data       :jsonb            not null
#  location   :geography        point, 4326
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_profiles_on_location            (location) USING gist
#  index_profiles_on_updated_at_and_age  (updated_at,age)
#  index_profiles_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile do
  subject { Fabricate :profile }

  describe 'fabrication' do
    it { is_expected.to be_a described_class }
    it { is_expected.to be_valid }
  end
end
