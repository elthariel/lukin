# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat::ApplicationMessage do
  let(:attributes) do
    {
      type: :application,
      profile_id: 'qwe',
      sent_at: DateTime.current,
      idx: 0
    }
  end

  subject { described_class.new(attributes) }

  describe 'Basic features' do
    it { is_expected.to be_valid }

    it "can be (de)serialized" do
      json = subject.to_json
      from_json = Chat::ApplicationMessage.from_json json

      expect(subject.class).to eq from_json.class
      expect(subject.idx).to eq from_json.idx
      expect(subject.profile_id).to eq from_json.profile_id
    end
  end
end
