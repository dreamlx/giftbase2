# coding: UTF-8
module Api
  class PostsController < Api::BaseController
    def index
      posts = Post.all
      render json: posts
    end

    def show
      post = Post.find(params[:id])
      render json: post
    end

    def create
      post = Post.new(params[:post])

      if post.save
        render json: post
      else
        render json: {msg: format_error_message(post.errors)}
      end
    end

    def update
      post = Post.find(params[:id])
      if post.update_attributes(params[:post])
        render json: post
      else
        render json: {msg: format_error_message(post.errors)}
      end
    end

    def destroy
      Post.find(params[:id]).destroy
      render json: {msg: "the post deleted"}
    end
  end
end
