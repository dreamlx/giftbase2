require 'spec_helper'

describe 'units' do
  describe "GET index" do
    it "should get all units to @units" do
      unit = create(:unit)
      get "/api/units"
      assigns(:units).should eq [unit]
    end
  end

  describe "GET show" do
    it "should get the request unit to @unit" do
      unit = create(:unit)
      get "/api/units/#{unit.id}"
      assigns(:unit).should eq unit
    end
  end

  describe "GET mine" do
    it "should get mine units" do
      create(:unit)
      get "/api/units/mine"
      # TODO current_user not available
    end
  end
end