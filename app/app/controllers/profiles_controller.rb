# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :load_profiles, only: :index
  before_action :load_profile, only: :show

  def index
  end

  def show
  end

  def edit
    @profile = current_profile
  end

  def update
    @profile = current_profile

    if @profile.update(profile_params)
      redirect_to profile_path(current_profile), notice: "Profile updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :title, :bio, :age, :weight, :height,
      :body, :position, :gender, :relationship
    )
  end

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
