# Server configuration. For a simple site this is just one entry.
role :app, %w{deployment@rooftop.vm.errorstudio.com}
role :web, %w{deployment@rooftop.vm.errorstudio.com}
role :db, %w{deployment@rooftop.vm.errorstudio.com}

# Git branch
set :branch, 'master'

#the base domain for this site - is appended to the primary domain for a prelaunch url
set :base_domain, "prelaunch.errorstudio.com"

# the prelaunch domain
set :prelaunch_domain, ->{"#{fetch(:primary_domain)}.#{fetch(:base_domain)}"}

# set the deploy domain to the prelaunch domain
set :deploy_domain, fetch(:primary_domain)

#redirects domains to the primary domain as a 301
set :domain_redirects, %w(~.*\.rooftopcms\.com)

#domains which this site will answer to (i.e. not redirect)
set :site_domains, [fetch(:deploy_domain), "~^.*\.rooftopcms\.io"]

#rewrites in nginx format - useful for specifying hard-coded urls for redirection after launch
set :url_rewrites, {}

#SSL settings
set :ssl_required, true
set :ssl_dir, File.join(File.dirname(__FILE__),"ssl")
set :ssl_cert, "rooftopcms.io.public.crt"
set :ssl_key, "rooftopcms.io.private.key.gpg" #this should be a gpg-encrypted key
set :ssl_dh, "rooftopcms.io.dh.pem.gpg" #this should be a gpg-encrypted key
# set :ip_address, "178.62.110.161" #the ip address for this site; required for SSL
set :force_ssl, true #redirect all non-ssl requests to ssl


#http basic auth
set :basic_auth_required, false
set :basic_auth_username, 'testing'
set :basic_auth_password, 'testing'