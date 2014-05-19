require 'will_paginate/array'
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @posts = Post.all
  end

  def all
    @posts = Post.all.reverse.paginate(:page => params[:page], :per_page => 8)
    
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def edit
    @user = current_user
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else 
      render 'new'
    end
  end

  def update
  end


  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:photo, :caption, :tags, :likes, :picture)
    end
end
