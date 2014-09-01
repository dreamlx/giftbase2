require 'spec_helper'

describe 'exams' do
  describe 'GET show' do
    before(:all)  { 300.times { create(:question)}}
    after(:all)   { Question.delete_all }

    it "should get 250 question when show" do
      get "/api/exams/question_group"

      json = JSON.parse(response.body)
      json["question_group"].count.should eq 250
      json["question_group"].first["options"].count.should  eq 4
      # json["question_group"].first["options"].should  eq ""
    end
  end
end