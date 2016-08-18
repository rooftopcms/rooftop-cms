# Server configuration. For a simple site this is just one entry.
role :app, [
    "deployment@rooftop-demo.vm.errorstudio.com"
]

role :web, [
    "deployment@rooftop-demo.vm.errorstudio.com"
]

role :db, %w{deployment@rooftop-demo.vm.errorstudio.com}

# Git branch
set :branch, 'master'

#the base domain for this site - is appended to the primary domain for a prelaunch url
set :base_domain, "prelaunch.errorstudio.com"

# the prelaunch domain
set :prelaunch_domain, ->{"#{fetch(:primary_domain)}.#{fetch(:base_domain)}"}

# set the deploy domain to the prelaunch domain
set :deploy_domain, 'demo.rooftopcms.io'

#redirects domains to the primary domain as a 301
set :domain_redirects, %w()

#domains which this site will answer to (i.e. not redirect)
set :site_domains, [fetch(:deploy_domain), "~^.*\.demo\.rooftopcms\.io"]

#rewrites in nginx format - useful for specifying hard-coded urls for redirection after launch
set :url_rewrites, {}

# Wordpress settings
set :db_host, `source public/.env.qa; echo $DB_HOST`.strip
set :db_prefix, `source public/.env.qa; echo $DB_PREFIX`.strip

#SSL settings
set :ssl_required, true
set :ssl_dir, File.join(File.dirname(__FILE__),"ssl")
set :ssl_cert, "docs.demo.rooftopcms.io.crt"
set :ssl_key, "docs.demo.rooftopcms.io.key.gpg" #this should be a gpg-encrypted key
set :ssl_dh, "rooftopcms.io.dh.pem.gpg" #this should be a gpg-encrypted key
#set :force_ssl, true #redirect all non-ssl requests to ssl

# Custom env vars for Rooftop
set :custom_env_vars, {
    "REDIS_HOST" => `source public/.env.qa; echo $REDIS_HOST`.strip,
    "REDIS_PORT" => `source public/.env.qa; echo $REDIS_PORT`.strip,
    "REDIS_DB" => `source public/.env.qa; echo $REDIS_DB`.strip,
}
