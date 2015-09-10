# Server configuration. For a simple site this is just one entry.
role :app, %w{deployment@rooftop-test.vm.errorstudio.com}
role :web, %w{deployment@rooftop-test.vm.errorstudio.com}
role :db, %w{deployment@rooftop-test.vm.errorstudio.com}

# Git branch
set :branch, 'master'

#the base domain for this site - is appended to the primary domain for a prelaunch url
set :base_domain, "prelaunch.errorstudio.com"

# the prelaunch domain
set :prelaunch_domain, ->{"#{fetch(:primary_domain)}.#{fetch(:base_domain)}"}

# set the deploy domain to the prelaunch domain
set :deploy_domain, fetch(:primary_domain)

#domains which this site will answer to (i.e. not redirect)
set :site_domains, [fetch(:deploy_domain), "~^.*\.rooftopcms\.io"]

#rewrites in nginx format - useful for specifying hard-coded urls for redirection after launch
set :url_rewrites, {}



#http basic auth
set :basic_auth_required, false
set :basic_auth_username, 'testing'
set :basic_auth_password, 'testing'
