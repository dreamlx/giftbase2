# coding: utf-8
require 'spec_helper'

describe "posts" do

  let(:valid_params) {
    {
      "post" => {
        "image" => Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/images/rails_copy.png')))
      }
    }
  }

  describe "GET show" do
    it "should get the request post" do
      post                        = create(:post)
      get "/api/posts/#{post.id}"
      json                        = JSON.parse(response.body)

      json["id"].should           eq post.id
      json["image"]["url"].should eq post.image.url
    end
  end

  describe "GET index" do
    it "should get all posts" do
      post                          = create(:post)
      get "/api/posts"
      json                          = JSON.parse(response.body).first

      json["id"].should_not         be_nil
      json["image"]["url"].should   eq post.image.url
    end
  end

  describe "POST create" do
    it "should create a new post" do
      post "/api/posts", valid_params
      json = JSON.parse(response.body)
      json["id"].should_not be_nil
      json["image"]["url"].should_not be_nil
    end

    it "should not create a new post when image is invalid" do
      post "/api/posts", {post: {image: "invalid image"}}
      json                              = JSON.parse(response.body)
      json["msg"].should                eq "image: 不能为空"
    end
  end

  describe "PUT update" do
    it "should edit the image" do
      post                              = create(:post)
      url                               = post.image.url

      put "/api/posts/#{post.id}", valid_params
      post.reload.image.url.should_not  be_nil
      post.reload.image.url.should_not  eq url
    end

    it "should not edit the image without valid params" do
      post                              = create(:post)
      url                               = post.image.url

      put "/api/posts/#{post.id}", {post: {image: "invalid image"}}

      json                              = JSON.parse(response.body)
      # json["msg"].should                eq "image: 不能为空"
      post.reload.image.url.should      eq url
    end
  end
end