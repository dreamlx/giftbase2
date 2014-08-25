require 'spec_helper'

describe "grades" do

  describe "POST update" do


  end

  describe "GET show" do
    it "should get grade @grade" do
      grade = create(:grade)
      get "/api/grades/#{grade.id}"
      assigns(:grade).should eq grade
    end
  end

  describe "GET index" do
    it "should get all grade with state" do
      grade = create(:grade)
      get "/api/grades?state=publish"

      assigns(:grades).should eq [grade]
    end

    it "should get the publish one without state" do
      grade = create(:grade, state: "publish")
      get "/api/grades"

      assigns(:grades).should eq [grade]
    end

    it "should get no grade without state, when no state is publish" do
      grade = create(:grade, state: "another state")
      get "/api/grades"

      assigns(:grades).should eq []      
    end
  end
end