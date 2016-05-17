# Server configuration. For a simple site this is just one entry.
role :app, [
    "deployment@rooftop-staging.vm.errorstudio.com"
]

role :web, [
    "deployment@rooftop-staging.vm.errorstudio.com"
]

role :db, %w{deployment@rooftop-staging.vm.errorstudio.com}

# Git branch
set :branch, 'development'

#the base domain for this site - is appended to the primary domain for a prelaunch url
set :base_domain, "prelaunch.errorstudio.com"

# the prelaunch domain
set :prelaunch_domain, ->{"#{fetch(:primary_domain)}.#{fetch(:base_domain)}"}

# set the deploy domain to the prelaunch domain
set :deploy_domain, 'staging.rooftopcms.io'

#redirects domains to the primary domain as a 301
set :domain_redirects, %w()

#domains which this site will answer to (i.e. not redirect)
set :site_domains, [fetch(:deploy_domain), "~^.*\.staging\.rooftopcms\.io"]

#rewrites in nginx format - useful for specifying hard-coded urls for redirection after launch
set :url_rewrites, {}

#http basic auth
set :basic_auth_required, true
set :basic_auth_username, 'staging'
set :basic_auth_password, 'staging'

# Wordpress settings
set :db_host, `source public/.env.staging; echo $DB_HOST`.strip
set :db_prefix, `source public/.env.staging; echo $DB_PREFIX`.strip

# Custom env vars for Rooftop
set :custom_env_vars, {
    "REDIS_HOST" => `source public/.env.staging; echo $REDIS_HOST`.strip,
    "REDIS_PORT" => `source public/.env.staging; echo $REDIS_PORT`.strip,
    "REDIS_DB" => `source public/.env.staging; echo $REDIS_DB`.strip,
}