require 'rvm/capistrano' 
require 'bundler/capistrano'   
require "capistrano/ext/multistage"     #多stage部署所需    

set :rvm_ruby_string, '1.9.3-p392@tzk3d'              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs

set :keep_releases, 3

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset

set :stages,        %w(pilot giftbase)    
set :default_stage, "pilot"    
set :stage_dir,     'app/config/deploy'

#tasks
namespace :deploy do
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :stop, :roles => :app do
    #do nonthing
  end
  
  desc "Symlink shared resources on each release - not used"
  task :symlink_shared, :roles => :app do
    run "rm -rf #{current_path}/public/uploads"
    run "mv #{current_path}/config/database.yml #{current_path}/config/database.yml.old"
    run "ln -sf #{shared_path}/uploads #{current_path}/public/"
    run "ln -sf #{shared_path}/database.yml #{current_path}/config/"
    run "rm #{current_path}/config/locales/appname.zh-CN.yml"
    run "ln -sf #{shared_path}/appname.zh-CN.yml #{current_path}/config/locales/"
    run "ln -sf #{shared_path}/carrierwave.rb #{current_path}/config/initializers/"
  end

  task :precompile, :roles => :web do  
    run "cd #{current_path} && #{rake} RAILS_ENV=production assets:precompile"  
  end  

end


after "deploy:update", "deploy:symlink_shared"
after "deploy:symlink_shared",  "deploy:migrate"
after "deploy:migrate", "deploy:precompile"
after "deploy:update", "deploy:cleanup"
#after 'deploy:update_code', 'deploy:change_db'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end