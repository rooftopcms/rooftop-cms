# Basic details
set :application, 'rooftop'
set :repo_url, 'ssh://git@github.com/rooftopcms/rooftop-cms'
set :primary_domain, "rooftopcms.io"

# The folder which will be the http root in nginx
set :http_root, "/current/public/web/wp"

# Peculiar to bedrock, the uploads folder is in a non-standard place.
# You don't need to set this for normal wordpress.
set :uploads_folder, 'public/web/app/uploads'

# Custom nginx rules for bedrock
set :custom_nginx_rules, [
]

# Custom nginx aliases
set :custom_nginx_aliases, ->{
    {
        "/app" => "#{current_path}/public/web/app;"
    }
}

#development settings
set :local_domain, "rooftop-cms.dev"
set :local_db_username, "root"
set :local_db_password, "root"
set :local_db_server, "vvv.dev"
set :local_db_server_port, 3306
set :local_db_name, "rooftop_cms"

#CORS required
set :include_nginx_cors, true

#Don't include HSTS - we front this with cloudflare which does add the header if we want
set :include_nginx_hsts, false
set :include_nginx_hpkp, false

# Include submodules. This requires the capistrano-git-submodule-strategy gem.
set :git_strategy, Capistrano::Git::SubmoduleStrategy

namespace :php do
    task :reload do
        on roles(:web) do
          execute "sudo invoke-rc.d php5-fpm restart"
        end
    end
end

namespace :deploy do
    desc "Deploy master to the DR environment"
    task :dr do
        system("cap dr deploy")
    end
end

after "deploy:finished", "php:reload"
