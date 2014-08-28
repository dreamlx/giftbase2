# coding: utf-8
require 'spec_helper'

describe 'user_tokens' do
  describe 'GET show' do
    it "should get the request user_token" do
      user = create(:user)

      get "/api/user_tokens/#{ user.authentication_token }"

      json = JSON.parse(response.body)
      json["user"]["id"].should     eq user.id
      json["auth_token"].should     eq user.authentication_token
      json["message"].should        eq 'user.authentication_token'
    end
  end

  describe "DELETE destroy" do
    it "should destroy the requested user token" do
      user = create(:user)
      user_token = user.authentication_token
      pp user_token
      delete "/api/user_tokens/#{ user.authentication_token }"

      response.status.should eq 204
      # json = JSON.parse(response.body)
      # json["user"]["id"].should                       eq user.id
      # json["user"]["authentication_token"].should_not eq user_token
      # json["message"].should                          eq "auth_token is empty now"
      user.reload
      user.authentication_token.should_not eq user_token
    end


    it "the request user to destroyed not found" do
      user = create(:user)
      user_token = user.authentication_token

      delete "/api/user_tokens/#{user_token + "hello"}"

      response.status.should eq 404
      # json = JSON.parse(response.body)
      # json["error"].should                       eq "Invalid token"
      user.reload
      user.authentication_token.should eq user_token
    end
  end

  describe 'POST create' do
    it "should create a new user_token" do
      user = FactoryGirl.create(:user_without_call_back)
      user.authentication_token.should be_nil

      post "/api/user_tokens", {user_token: { email: user.email, password: user.password, username: user.username}}

      json              = JSON.parse(response.body)
      user_token_json  = json["user_token"]
      user_json        = json["users"].first

      user_token_json["token"].should_not    be_nil
      user_token_json["user_id"].should      eq user.id
      user_json["id"].should                 eq user.id
      user_json["email"].should              eq user.email
      user_json["username"].should           eq user.username
    end

    it "should return error when no email" do
      user = create(:user)
      post "/api/user_tokens", {user_token: { email: nil, password: user.password, name: user.username}}

      json = JSON.parse(response.body)
      json["error"].should eq "The request must contain the user email and password."
    end

    it "should return error when no password" do
      user = create(:user)
      post "/api/user_tokens", {user_token: { email: user.email, password: nil, name: user.username}}

      json = JSON.parse(response.body)
      json["error"].should eq "The request must contain the user email and password."
    end

    it "should return error when no user found" do
      post "/api/user_tokens", {user_token: { email: "admin@gmail.com", password: "email.password", name: "user.username"}}

      json = JSON.parse(response.body)
      json["errors"]["user"].should eq ["用户不存在"]
    end

    it "should return error with wrong password" do
      user = create(:user)
      post "/api/user_tokens", {user_token: { email: user.email, password: "wrongpassword", name: user.username}}

      json = JSON.parse(response.body)
      json["errors"]["password"].should eq ["密码错误"]      
    end
  end
end