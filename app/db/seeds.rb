# frozen_string_literal: true

# This file should ensure the existence of records required to run the application
# in every environment (production, development, test). The code here should be
# idempotent so that it can be executed at any point in every environment. The
# data can then be loaded with the bin/rails db:seed command (or created alongside
# the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Rails.env.development?
  admin_email = 'admin@example.com'
  # default_email = 'default@example.com'
  password = 'qweasdzxc'

  unless AdminUser.exists?(email: admin_email)
    puts 'Creating an AdminUser'
    AdminUser.create!(
      email: admin_email,
      password: password,
      password_confirmation: password
    )
  end

  unless User.exists?(email: admin_email)
    puts 'Creating a regular User'
    Fabricate :user,
      email: admin_email,
      password: password
  end

  if Profile.count < 100
    puts "Creating 100 profiles. It's going to take a moment..."
    Fabricate.times 100, :profile
    puts "Done !"
  end
end
