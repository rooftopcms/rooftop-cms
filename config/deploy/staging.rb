# Server configuration. For a simple site this is just one entry.
role :app, %w{deployment@ed-test.vm.errorstudio.com}
role :web, %w{deployment@ed-test.vm.errorstudio.com}
role :db, %w{deployment@ed-test.vm.errorstudio.com}

# Git branch
set :branch, 'development'

#the base domain for this site - is appended to the primary domain for a prelaunch url
set :base_domain, "staging.errorstudio.com"

# the prelaunch domain
set :prelaunch_domain, ->{"#{fetch(:primary_domain)}.#{fetch(:base_domain)}"}

#domains which this site will answer to (i.e. not redirect)
set :site_domains, [fetch(:prelaunch_domain)]
#redirects domains to the primary domain as a 301
set :domain_redirects, %w()

#rewrites in nginx format - useful for specifying hard-coded urls for redirection after launch
set :url_rewrites, {}

# set the deploy domain to the prelaunch domain
set :deploy_domain, fetch(:prelaunch_domain)

#http basic auth
set :basic_auth_required, true
set :basic_auth_username, 'testing'
set :basic_auth_password, 'testing'

# set :deploy_to, ->{"/var/www/#{fetch(:deploy_domain)}"}
