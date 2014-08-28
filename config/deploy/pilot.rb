
# main details
set :application, "pilot-training"
set :keep_releases, 10 
role :web, "42.120.9.87"                          # Your HTTP server, Apache/etc
role :app, "42.120.9.87"                          # This may be the same as your `Web` server
role :db,  "42.120.9.87", :primary => true 

#server details
default_run_options[:pty] = true  # Must be set for the password prompt
set :deploy_to, "/home/dreamlinx/ROR/pilot-training.com"
set :user, "dreamlinx"
set :use_sudo, false
set :ssh_options, { :forward_agent => true }
#repo details
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_username, "dreamlx"
set :scm_passphrase, "github2melx"
set :repository,  "git@github.com:dreamlx/giftbase2.git"
set :branch, "questions"
set :deploy_via, :remote_cache