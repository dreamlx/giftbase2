# encoding: utf-8
require 'spec_helper'

describe "scores" do
  describe "GET index" do
    it "should get all score by user" do
      user1         = create(:user)
      user1.reset_authentication_token
      user1.save
      user2         = create(:user)
      user2.reset_authentication_token
      user2.save
      score1        = create(:score, user: user1, number: 89.5)
      score2        = create(:score, user: user2, number: 90)

      get "/api/scores", {"auth_token" => user1.authentication_token}

      json = JSON.parse(response.body)
      json["error"].should        eq 1
      json["msg"].should          eq "succeed"
      json["scores"].count.should eq 1
    end
  end

  describe "GET topten" do
    it "should get topten" do
      user = create(:user)
      user1 = create(:user)
      3.times { create(:score, user_id: user.id)}
      2.times { create(:score, user_id: user1.id)}

      get "/api/scores/topten"

      json                              = JSON.parse(response.body)
      json["error"].should                        eq 1
      json["msg"].should                          eq "succeed"
      json["scores"].count.should                 eq 2
      json["scores"].first["username"].should_not be_nil
      json["scores"].first["time"].should_not     be_nil
      json["scores"].first["number"].should_not   be_nil
    end
  end

  describe "POST create" do
    it "should create a new score" do
      user                          = create(:user)
      user.reset_authentication_token
      user.save
      post "/api/scores", {"auth_token" => user.authentication_token, "score" => {"user_id" => user.id, "number" => 10}}
      # response.status.should        eq 201
      json                          = JSON.parse(response.body)
      json["error"].should                    eq 1
      json["msg"].should                      eq "succeed"
      json["score"]["user_id"].should         eq user.id
      json["score"]["number"].should          eq 10
      json["score"]["created_at"].should_not  be_nil
    end

    it "should get errors when param invalid: user nil" do
      user                          = create(:user)
      user.reset_authentication_token
      user.save
      post "/api/scores", {"auth_token" => user.authentication_token, "score" => {"user_id" => nil, "number" => 10}}
      # response.status.should        eq 422
      json                          = JSON.parse(response.body)
      json["error"].should  eq 0
      json["msg"].should    eq "用户: 不能为空"
    end
    it "should get errors when param invalid: number nil" do
      user                          = create(:user)
      user.reset_authentication_token
      user.save
      post "/api/scores", {"auth_token" => user.authentication_token, "score" => {"user_id" => user.id, "number" => nil}}
      # response.status.should        eq 422
      json                          = JSON.parse(response.body)
      json["error"].should  eq 0
      json["msg"].should    eq "成绩: 不能为空"
    end
  end
end