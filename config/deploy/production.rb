# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{ec2-54-199-246-203.ap-northeast-1.compute.amazonaws.com}
# role :web, %w{deploy@example.com}
# role :db,  %w{deploy@example.com}
set :branch, ENV.fetch('BRANCH', 'master')


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server 'ec2-54-199-246-203.ap-northeast-1.compute.amazonaws.com', user: 'apps', roles: %w{app}
server 'ec2-54-199-246-203.ap-northeast-1.compute.amazonaws.com', user: 'ec2-user', roles: %w{app}
set :stage, :production
set :application, 'omote'

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
 set :ssh_options, {
   keys:"#{ENV.fetch('HOME')}/.ssh/private/omote-production.pem",
   forward_agent: false,
   port: 22
 }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
