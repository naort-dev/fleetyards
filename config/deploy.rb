set :shared_dirs, [
  'public/uploads',
  'tmp/pids',
  'tmp/sockets',
  'dumps'
]

set :shared_files, [
  'config/secrets.yml',
  'config/database.yml'
]

set :stages, %w(local production)
set :default_stage, 'local'

require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/scp'

set :user, 'fleetyards'
set :forward_agent, true

set :deploy_to, '/home/fleetyards'
set :repository, 'https://github.com/mortik/fleetyards'
set :rails_env, 'production'
set :branch, 'master'

task :environment do
  invoke :'rbenv:load'
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    command %(rbenv install -s)
    command %(gem update --system 2.6.10)
    command %(gem install bundler --silent)
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'server:phased_restart'
    end
  end
end

namespace :server do
  task :phased_restart do
    invoke :'rbenv:load'
    command %(bundle exec pumactl -P tmp/pids/puma.pid -S tmp/sockets/puma.state phased-restart)
    command %(sudo supervisorctl restart fleetyards:fleetyards-worker)
  end

  task :restart do
    comment 'Restart Application'
    command %(sudo supervisorctl restart fleetyards:*)
  end

  task :stop do
    comment 'Stopping Application'
    command %(sudo supervisorctl stop fleetyards:*)
  end

  task :start do
    comment 'Starting Application'
    command %(sudo supervisorctl start fleetyards:*)
  end
end

namespace :db do
  task load_schema: :environment do
    in_path fetch(:current_path).to_s do
      invoke :'server:stop'
      comment %(Loading Schema for database)
      command %(#{fetch(:rake)} db:schema:load)
      invoke :'server:start'
    end
  end

  task migrate: :environment do
    in_path fetch(:current_path).to_s do
      comment %(Migrating database)
      command %(#{fetch(:rake)} db:migrate)
    end
  end

  task backup: :environment do
    in_path fetch(:current_path).to_s do
      comment "Creating DB Backup..."
      command %(bundle exec thor db:dump)
      comment "DB Backup finished"
    end
  end

  task local_import: :download_backup do
    command %(pg_restore --verbose --clean --no-acl --no-owner -h localhost -d fleetyards_dev dumps/latest.dump)
  end

  task download_backup: :backup do
    comment "Downloading latest backup..."
    command %(scp #{fetch(:user)}@#{fetch(:domain)}:#{fetch(:deploy_to)}/shared/dumps/latest.dump dumps/)
    comment "Download finished"
  end
end
