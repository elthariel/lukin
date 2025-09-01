# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :load_profiles, only: :index
  before_action :load_profile, only: :show

  def index
  end

  def show
  end

  private

  def load_profile
    @profile = Profile
      .with_distance(current_location)
      .find(params[:id])
    @distance = @profile.distance if @profile.respond_to?(:distance)
  end

  def load_profiles
    @profiles = Profile
      .by_distance(current_location)
      .connected
      .limit(40)
  end
end
