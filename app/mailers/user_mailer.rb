class UserMailer < ActionMailer::Base
  email_config = YAML::load(File.read(Rails.root.to_s + '/config/email_config.yml'))
  default from: "#{email_config['email']}"

  def confirmation
  	mail(:subject => 'Your Invoice', :to => "duxiaolong92@gmail.com")
  end

end
