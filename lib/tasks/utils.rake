require 'rake'
namespace :utils do
 
  desc "aready admin email confirm"
  task :confirm_admin_email => :environment do
    users = User.where(role: "admin")
    users.each do |user|
      user.confirm! unless user.confirmed?
    end
  end
 
end