# frozen_string_literal: true

#
# We need the tailwindcss-rails gem for active admin, but we don't use it for
# our main tailwind code, which is handled by Vite, so we need to disable the
# default rule
#

tailwind_task = 'tailwindcss:build'
task = Rake::Task['assets:precompile']

task.prerequisites.delete(tailwind_task) if task.prerequisites.include?(tailwind_task)

desc 'Build ActiveAdmin tailwind CSS'
task 'assets:activeadmin': :environment do
  cmd = [
    'bundle exec tailwindcss',
    '-i app/assets/stylesheets/active_admin.css',
    '-o app/assets/builds/active_admin.css',
    '--minify',
    '-c tailwind-active_admin.config.js'
  ].join(' ')

  system(cmd)
end

# Make the assets:precompile depends on our active admin css build
task.enhance(['assets:activeadmin'])
