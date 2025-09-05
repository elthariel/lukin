# == Schema Information
#
# Table name: chats
#
#  id         :uuid             not null, primary key
#  messages   :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Chat, type: :model do
  subject { Fabricate :chat }

  describe 'fabrication' do
    it { is_expected.to be_a described_class}
    it { is_expected.to be_valid }
  end

  describe 'Message store' do
    let(:msg) { Fabricate.build_times 2, :text_message }

    describe '#add_message' do
      it "adds a message" do
        expect { subject.add_message msg[0] }.to change{subject.messages.count}.by(1)
      end

      it "sets sent_at and idx" do
        subject.add_message msg[0]
        subject.add_message msg[0]

        expect(subject.messages.last.sent_at).not_to eq msg[0].sent_at
        expect(subject.messages.last.idx).to eq 1
      end

      it "limits the number of messages in history" do
        attrs = msg[0].attributes
        Chat::Messages::HISTORY_CLEANUP.times do
          subject.messages_raw.append(attrs)
        end

        subject.valid? # Triggers the cleanup
        expect(subject.messages.count).to eq(Chat::Messages::HISTORY_LIMIT)
      end
    end
  end
end
