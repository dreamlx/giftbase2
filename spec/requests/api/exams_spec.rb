require 'spec_helper'

describe 'exams' do
  describe 'GET show' do
    before(:all)  { 300.times { create(:question)}}
    after(:all)   { Question.delete_all }

    it "should get 80 questiones when show" do
      user = create(:user)
      get "/api/exams/question_group" #, { auth_token: user.authentication_token}

      json = JSON.parse(response.body)
      json["error"].should                eq 1
      json["msg"].should                  eq "succeed"
      json["question_group"].count.should eq 80
      json["question_group"].first["options"].count.should  eq 4
    end
  end
end