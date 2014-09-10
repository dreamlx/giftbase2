require 'spec_helper'

describe "scores" do
  describe "GET index" do
    it "should get all score by user" do
      user1         = create(:user)
      user2         = create(:user)

      score1        = create(:score, user: user1, number: 89.5)
      score2        = create(:score, user: user2, number: 90)

      get "/api/scores", {"auth_token" => user1.authentication_token}

      json = JSON.parse(response.body)["scores"]
      json.count.should eq 1
    end
  end

  describe "GET topten" do
    it "should get topten" do
      user = create(:user)
      50.times { create(:score)}

      get "/api/scores/topten"

      json                              = JSON.parse(response.body)["scores"]
      json.count.should                 eq 10
      json.first["username"].should_not be_nil
      json.first["time"].should_not     be_nil
      json.first["number"].should_not   be_nil
    end
  end

  describe "POST create" do
    it "should create a new score" do
      user                          = create(:user)
      post "/api/scores", {"score" => {"user_id" => user.id, "number" => 10}}
      response.status.should        eq 201
      json                          = JSON.parse(response.body)["score"]
      json["user_id"].should        eq user.id
      json["number"].should         eq 10
      json["created_at"].should_not be_nil
    end
  end
end