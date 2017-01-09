# config valid only for Capistrano 3.1
lock '3.7.1'
set :application, 'omote'

##### env config
DEPLOY_DIR = "/home/ec2-user/#{fetch(:application)}"
TIME_OUT = 60
DOMAIN = 'ec2-54-199-246-203.ap-northeast-1.compute.amazonaws.com'
set :repo_url, 'https://github.com/penguinwokrs/omote.git'
# cap deploy nginx conf
# set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_server_name, DOMAIN
#####

# ruby version
set :rbenv_ruby, '2.3.1'
# set :linked_files, %w{.rbenv-vars}
set :deploy_to, DEPLOY_DIR

# rbenv
set :rbenv_type, :system
# set :rbenv_custom_path, '/usr/local/rbenv'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{puma.rb}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


# bundle
set :bundle_path, -> { shared_path.join('vendor/bundle') }

# puma
set :puma_threds, [4, 16]
set :puma_workers, 0
set :puma_bind, "unix://#{release_path}/tmp/sockets/puma.sock"
set :puma_state, "#{release_path}/tmp/pids/puma.state"
set :puma_pid, "#{release_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, TIME_OUT
set :puma_init_active_record, true # Change to false when not using ActiveRecord

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :confirm do
    on roles(:app) do
      puts "This stage is '#{fetch(:stage)}'. Deploying branch is '#{fetch(:branch)}'."
    end
  end

  desc 'Initial Deploy'
  task :initial do
    # on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    # end
  end

  before :starting, :confirm
  after :finishing, :compile_assets
  after :finishing, :cleanup

# namespace :deploy do
#
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       # execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end
#
#   after :publishing, :restart
#
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end
end
