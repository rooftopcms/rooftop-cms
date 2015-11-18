# Basic details
set :application, 'rooftop'
set :repo_url, 'ssh://git@github.com/rooftopcms/rooftop-cms'
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

#CORS required
set :include_nginx_cors, true

# Include submodules. This requires the capistrano-git-submodule-strategy gem.
set :git_strategy, Capistrano::Git::SubmoduleStrategy