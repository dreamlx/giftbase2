FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "johndoe#{n}@example.com"}
    role              "admin"
    avatar            "this is a user avatar"
    gender            "man"
    username          "this is a user name"
    avatar_id         10
    birthday          Time.now
    home_address      "this is user home address"
    password          "12345678"
    school_name       "this is a user school name"
    school_address    "this is a user school address"
    qq                123456
    parent_name       "this is a user parent name"    
    phone             "this is a phone number"
    unconfirmed_email "this is a user unconfirm email"
    class_no          "this is a user class number"
  end
end