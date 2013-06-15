require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :domain, 'danode'
set :user, 'deployer'
set :deploy_to, '/home/deployer/apps/iuliastockton.com'
set :repository, 'http://github.com/iuliastockton/iuliastockton.com.git'
set :branch, 'master'
set :term_mode, :system

task :environment do
end

task :setup => :environment do
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'

    to :launch do
      queue! %[sudo rm "/etc/nginx/sites-enabled/iuliastockton.com"]
      queue! %[sudo ln -s "#{deploy_to}/current/config/nginx" "/etc/nginx/sites-enabled/iuliastockton.com"]
      queue 'sudo systemctl restart nginx'
    end
  end
end
