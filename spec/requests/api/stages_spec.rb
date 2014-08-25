require 'spec_helper'

describe "stages" do
  describe "GET index" do
    it "should get all stage" do
      stage = create(:stage)

      get "/api/stages"

      assigns(:stages).should eq [stage]
    end

    it "should get all stage according to the position" do
      high_stage  = create(:stage, position: 50)
      low_stage   = create(:stage, position: 10)

      get "/api/stages"

      assigns(:stages).first.should eq low_stage
    end
  end

  describe "GET show" do
    it "should get stage requested" do
      user    = create(:user)
      stage   = create(:stage) 

      get "/api/stages/#{stage.id}"

      # assigns(:stage).should eq ""
      # TODO the current_user is not available.
    end
  end
end