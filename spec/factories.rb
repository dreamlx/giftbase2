FactoryGirl.define do
  factory :user do
  	username "xiaoxiao"
    email    "xiaoxiao@gmail.com"
    password "11111111"
    password_confirmation "11111111"
    role      "student"
  end
end