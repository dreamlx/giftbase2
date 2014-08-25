require 'spec_helper'

describe "users" do
  describe "GET show" do
    it "should get the request user" do
      user = create(:user)

      get "/api/users/#{user.id}"
      json = JSON.parse(response.body)["user"]
      # json.should eq ""
      json["avatar"]["url"].should  eq user.avatar.url
      json["username"].should       eq user.username
      json["gender"].should         eq user.gender
      json["phone"].should          eq user.phone
      json["school_name"].should    eq user.school_name
      # json["high_goals"].should     eq user.high_goals
    end
  end

  describe "POST edit user info" do
    it "should edit the username" do
      user = create(:user)

      post "/api/users/#{user.id}/edit_username?username=newname"

      json = JSON.parse(response.body)["user"]
      json["username"].should eq "newname"
    end

    it "should edit the gender" do
      user = create(:user, gender: "man")
      post "/api/users/#{user.id}/edit_gender?gender=woman"

      json = JSON.parse(response.body)["user"]
      json["gender"].should eq "woman"     
    end

    it "should edit the phone" do
      user = create(:user, phone: "12345678900")
      post "/api/users/#{user.id}/edit_phone?phone=12345678901"

      json = JSON.parse(response.body)["user"]
      json["phone"].should eq "12345678901"     
    end

    it "should edit the school_name" do
      user = create(:user, school_name: "eastfly")
      post "/api/users/#{user.id}/edit_school_name?school_name=westfly"

      json = JSON.parse(response.body)["user"]
      json["school_name"].should eq "westfly"     
    end

    it "should change the avatar pic" do
      # user = create(:user)
      # post "/api/users/#{user.id}/edit_avatar?avatar=westfly"

      # json = JSON.parse(response.body)["user"]
      # json["avatar"]["url"].should eq "westfly" 

      # TODO change the avatar pic
    end
  end
end