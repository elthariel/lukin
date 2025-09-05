# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :load_profile, only: :create
  before_action :load_chat, except: :create

  def create
    @chat = Chat.find_or_create_between!(current_profile, @profile)

    redirect_to chat_path(@chat)
  end

  def show
    @other_profile = @chat.other_profile_for(current_profile)
  end

  private

  def load_profile
    @profile = Profile.find(params[:profile_id])
  end

  def load_chat
    @chat = Chat.find(params[:id])
  end
end
