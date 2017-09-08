# Include error deployment tasks (everything else is loaded there.)
require 'capistrano/errorstudio/wordpress'
require 'capistrano/git-submodule-strategy'
require 'capistrano/errorstudio/cron'



Rake::Task["nginx:check_config"].clear
Rake::Task["nginx:generate_config"].clear
