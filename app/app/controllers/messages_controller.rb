# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :load_chat

  def index
    # respond_to do |fmt|
    #   fmt.turbo_stream { head :ok }
    #   fmt.html { redirect_to chat_path(@chat) }
    # end
  end

  def create
    message = Chat.message.from_hash message_params

    if message.valid?
      @chat.add_message(message)
      if @chat.save
        render :message
      else
        head :unprocessable_content
      end
    else
      head :unprocessable_content
    end
  end

  private

  def load_chat
    @chat = Chat.find(params[:chat_id])
    @messages = @chat.messages
  end

  def message_params
    params.require(:message).permit(:type, :text)
  end
end
