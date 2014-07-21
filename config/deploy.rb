# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'testheroku'
set :repo_url, 'https://github.com/jarredszabadi/testheroku.git'
set :deploy_to, '/home/deploy/apps/testHeroku'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
 set :keep_releases, 5



#after "deploy", "deploy:cleanup" # keep only the last 5 releases

# namespace :deploy do
#   %w[start stop restart].each do |command|
#     desc "#{command} unicorn server"
#     task command, roles: :app, except: {no_release: true} do
#       run "/etc/init.d/unicorn_#{application} #{command}"
#     end
#   end

#   task :setup_config do
#     on roles: :app do
#       sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
#       sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
#       run "mkdir -p #{shared_path}/config"
#       put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
#       puts "Now edit the config files in #{shared_path}."
#     end
#   end
#   after "deploy:setup", "deploy:setup_config"

#   task :symlink_config do
#     on roles: :app do
#       sudo "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#     end
#   end
#   after "deploy:finalize_update", "deploy:symlink_config"

#   desc "Make sure local git is in sync with remote."
#   task :check_revision do
#     on roles: :web do
#       unless `git rev-parse HEAD` == `git rev-parse origin/master`
#         puts "WARNING: HEAD is not the same as origin/master"
#         puts "Run `git push` to sync changes."
#         exit
#       end
#     end
#   end
#   before "deploy", "deploy:check_revision"
# end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

end
