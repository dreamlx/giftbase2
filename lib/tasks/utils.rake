require 'rake'
namespace :utils do
 
  desc "aready admin email confirm"
  task :confirm_admin_email => :environment do
    users = User.where(role: "admin")
    users.each do |user|
      user.confirm! unless user.confirmed?
    end
  end

  desc "set default question_level "
  task :set_default_question_level => :environment do
  	questions = Question.all
  	ql = QuestionLevel.first
  	questions.each do |question|
  	 question.question_level = ql
  	 if question.save
  	   puts "#{question.id} set default question level success"
  	 else
  	   puts "#{question.id} set default question level failed"
  	 end
  	end
  end
 
end