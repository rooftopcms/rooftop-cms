# Server configuration. For a simple site this is just one entry.
role :app, [
    "deployment@rooftop-web01.hosts.errorstudio.com",
    "deployment@rooftop-web02.hosts.errorstudio.com"
]

role :web, [
    "deployment@rooftop-web01.hosts.errorstudio.com",
    "deployment@rooftop-web02.hosts.errorstudio.com"
]

role :db, %w{deployment@rooftop-db01.hosts.errorstudio.com}, no_release: true

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
#set :force_ssl, true #redirect all non-ssl requests to ssl

#http basic auth
set :basic_auth_required, false
set :basic_auth_username, 'testing'
set :basic_auth_password, 'testing'

# Wordpress settings
set :db_host, "db01.rooftop"
set :db_prefix, `source public/.env.production; echo $DB_PREFIX`.strip

# Custom env vars for Rooftop
set :custom_env_vars, {
    "REDIS_HOST" => `source public/.env.production; echo $REDIS_HOST`.strip,
    "REDIS_PORT" => `source public/.env.production; echo $REDIS_PORT`.strip,
    "REDIS_DB" => `source public/.env.production; echo $REDIS_DB`.strip,
    "CLOUDFLARE_EMAIL" => `source public/.env.production; echo $CLOUDFLARE_EMAIL`.strip,
    "CLOUDFLARE_API_KEY" => `source public/.env.production; echo $CLOUDFLARE_API_KEY`.strip,
    "CLOUDFLARE_DOMAIN_ZONE" => `source public/.env.production; echo $CLOUDFLARE_DOMAIN_ZONE`.strip,
    "CLOUDFLARE_CDN_DOMAIN_ZONE" => `source public/.env.production; echo $CLOUDFLARE_CDN_DOMAIN_ZONE`.strip

}

# Custom settings for nginx
http_context = <<-CONTEXT
set_real_ip_from 10.0.0.0/8;
add_header X-Rooftop-Backend $hostname;
CONTEXT
set :nginx_custom_http_context, http_context

# Set upload size (managed in WP to 100M)
set :nginx_custom_server_context, "client_max_body_size 256M;"


set :log_formats, {
    "with_subdomain_and_time" => '$remote_addr [$time_local] $host $request $status $body_bytes_sent $http_user_agent $request_time $upstream_response_time',
    "logentries_json" => '{ "time": "$time_iso8601", "remote_addr": "$remote_addr", "host": "$host", "body_bytes_sent": "$body_bytes_sent", "request_time": "$request_time", "status": "$status", "request": "$request", "request_method": "$request_method", "http_user_agent": "$http_user_agent", "request_time": "$request_time", "upstream_response_time": "$upstream_response_time" }'
}

set :access_log, "syslog:server=unix:/dev/log,facility=local7,tag=nginx,nohostname logentries_json"
set :error_log, "syslog:server=unix:/dev/log,facility=local7,tag=nginx,severity=error,nohostname"

namespace :wordpress do
  namespace :db do
    desc "Copy secrets for Wordpress from an encrypted file"
    task :configure_secrets do
      on roles :app do
        unless test("[ -f #{shared_path}/.env ]")
          set :gpg_phrase, ask("GPG passphrase for the encrypted secrets:",nil)
          yaml = `echo #{fetch(:gpg_phrase)} | gpg -d -q --batch --passphrase-fd 0 --no-mdc-warning #{File.join(File.dirname(__FILE__),"wordpress_config","shared_strings.yml.gpg")}`
          strings = YAML.load(yaml)
          strings.each do |k,v|
            set k.to_sym, v
          end
        end
      end

    end
  end
end
before 'wordpress:db:create_config', 'wordpress:db:configure_secrets'

after "deploy:finished", "deploy:dr"
