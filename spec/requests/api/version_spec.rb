# encoding: utf-8
require 'spec_helper'

describe 'version' do
  describe "GET version" do
    it "should get version of app" do
      get "/api/version"

      json = JSON.parse(response.body)

      json["version"] = "1.0"
    end
  end
end