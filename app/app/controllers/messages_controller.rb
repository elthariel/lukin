# frozen_string_literal: true

class MessagesController < ApplicationController
  include TurboStreamConcern

  before_action :load_chat

  def index
  end

  def create
    message = Chat.message.from message_params
    message.profile_id = current_profile.id

    @message = @chat.add_message(message)
    if @chat.save
      turbo.broadcast_append_to @other_chat_link,
        target: "chat-messages-#{@chat.id}",
        partial: 'messages/message',
        locals: { chat: @chat, message: @message, me: false}

      respond_to do |fmt|
        fmt.turbo_stream
        fmt.html { redirect_to chat_path(@chat) }
      end
    else
      head :unprocessable_content
    end
  end

  private

  def load_chat
    @chat = Chat.includes(:chat_links).find(params[:chat_id])
    @messages = @chat.messages

    @chat_link = @chat.chat_link_for(current_profile)
    @other_chat_link = @chat.other_chat_link_for(current_profile)
  end

  def message_params
    params.require(:message).permit(:type, :text)
  end
end
