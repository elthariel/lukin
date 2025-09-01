# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :load_profiles, only: :index
  before_action :load_profile, except: :index

  private

  def load_profile
    @profile = Profile.find(params[:id])
  end

  def load_profiles
    @profiles = Profile
  end
end
