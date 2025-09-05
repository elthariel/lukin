# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController do
  let(:chat ) { Fabricate :chat }
  let(:user) { chat.users.first }

  before(:all) do
    Rails.application.routes.eager_load!
  end

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST /chat/:chat_id/messages' do
    let(:message) do
      {
        type: :text,
        text: 'test'
      }
    end

    subject do
      sign_in user
      post :create, params: {
          chat_id: chat.id,
          message:
        }
    end

    it "adds a message" do
      expect { subject }.to change { chat.reload.messages.count }.by 1
      expect(chat.messages.last).to be_a(Chat::TextMessage)
      expect(chat.messages.last.text).to eq 'test'
    end
  end
end
