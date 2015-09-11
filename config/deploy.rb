# Basic details
set :application, 'rooftop'
set :repo_url, 'ssh://git@bitbucket.org/errorstudio/rooftop-cms'
set :primary_domain, "rooftopcms.io"


# The folder which will be the http root in nginx
set :http_root, "/current/public/web"

# Peculiar to bedrock, the uploads folder is in a non-standard place.
# You don't need to set this for normal wordpress.
set :uploads_folder, 'public/web/app/uploads'

# Custom nginx rules for bedrock
set :custom_nginx_rules, [
      "rewrite ^/(wp-.*.php)$ /wp/$1 last;",
      "rewrite ^/(wp-(content|admin|includes).*) /wp/$1 last;"
]

#development settings
set :local_domain, "rooftop-cms.dev"
set :local_db_username, "root"
set :local_db_password, "root"
set :local_db_server, "vvv.dev"
set :local_db_server_port, 3306
set :local_db_name, "rooftop_cms"

# require specific recipes last.
require 'capistrano/errorstudio/wordpress'
require 'capistrano/errorstudio/composer'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

