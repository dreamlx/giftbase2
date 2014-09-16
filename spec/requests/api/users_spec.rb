# coding: utf-8
require 'spec_helper'

describe "users" do

  let(:valid_params) {
    {
      "user" => {
        "username"  => "amo2",
        "password"  => "11111111",
        "email"     => "c@gmail.com"
      }
    }
  }

  let(:invalid_params) {
    {
      "user" => {
        "username"  => "amo2",
        "password"  => "11111111",
        "email"     => nil
      }
    }
  }
  describe "GET show" do
    it "should get the request user" do
      user = create(:user)
      user.reset_authentication_token
      user.save

      get "/api/users/#{user.id}", { auth_token: user.authentication_token}

      # response.status.should        eq 200
      json = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"

      user_json                         = json["user"]
      user_json["avatar"]["url"].should eq user.avatar.url
      user_json["username"].should      eq user.username
      user_json["gender"].should        eq user.gender
      user_json["phone"].should         eq user.phone
      user_json["email"].should         eq user.email
      user_json["school_name"].should   eq user.school_name
    end
  end

  describe "GET profile" do
    it "should get the request user according to authen_token" do
      user = create(:user)
      score1 = create(:score, user: user)
      score2 = create(:score, user: user)
      score3 = create(:score, user: user)
      user.reset_authentication_token
      user.save

      get "/api/users/profile", { auth_token: user.authentication_token}

      # response.status.should        eq 200
      json = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"

      user_json                         = json["user"]
      user_json["avatar"]["url"].should eq user.avatar.url
      user_json["username"].should      eq user.username
      user_json["gender"].should        eq user.gender
      user_json["phone"].should         eq user.phone
      user_json["email"].should         eq user.email
      user_json["school_name"].should   eq user.school_name
      user_json["topscore"].should      eq Score.maximum(:number)
    end
  end

  describe "POST create" do
    it "should create a new user" do
      post "/api/users", valid_params
      # response.status.should          eq 201
      json = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"

      json["user"]["username"].should   eq "amo2"
      json["user"]["email"].should      eq "c@gmail.com"
      json["user"]["id"].should_not     be_nil
      json["auth_token"].should_not     be_nil
    end

    it "should not create a new user when email is nil" do
      post "/api/users", invalid_params
      # response.status.should                eq 401
      json                              = JSON.parse(response.body)
      json["error"].should              eq 0
      json["msg"].should                eq "email: 不能为空"
    end
  end

  describe "PUT update" do
    it "should edit the username" do
      user = create(:user)
      user.reset_authentication_token
      user.save

      put "/api/users/#{user.id}", {auth_token: user.authentication_token, "user" => { "username" => "newname"}}

      json = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"
      json["user"]["username"].should   eq "newname"
    end

    it "should edit the gender" do
      user = create(:user, gender: "man")
      user.reset_authentication_token
      user.save

      put "/api/users/#{user.id}", {auth_token: user.authentication_token, "user" => { "gender" => "woman"}} 

      json                              = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"
      json["user"]["gender"].should     eq "woman"     
    end

    it "should edit the phone" do
      user = create(:user, phone: "12345678900")
      user.reset_authentication_token
      user.save

      put "/api/users/#{user.id}", {auth_token: user.authentication_token, "user" => { "phone" => "12345678901"}}

      json                              = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"
      json["user"]["phone"].should      eq "12345678901"     
    end

    it "should edit the school_name" do
      user = create(:user, school_name: "eastfly")
      user.reset_authentication_token
      user.save

      put "/api/users/#{user.id}", {auth_token: user.authentication_token, "user" => { "school_name" => "westfly"}}

      json                              = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"
      json["user"]["school_name"].should eq "westfly"     
    end

    it "should change the avatar pic" do
      user = create(:user)
      user.reset_authentication_token
      user.save

      url = user.avatar.url
      put "/api/users/#{user.id}", {auth_token: user.authentication_token, "user" => { "avatar" => Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/images/rails_copy.png')))}}

      json                              = JSON.parse(response.body)
      json["error"].should              eq 1
      json["msg"].should                eq "succeed"      
      json["user"]["avatar"]["url"].should_not eq url
    end
  end
end