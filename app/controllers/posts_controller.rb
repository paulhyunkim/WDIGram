require 'will_paginate/array'
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @user = current_user
    @posts = Post.all
  end

  def all
    @posts = Post.all.reverse.paginate(:page => params[:page], :per_page => 10)
    
  end

  def show

  end

  def new
    @user = current_user
    @post = Post.new
  end

  def edit
    @user = current_user
  end

  def create
    #@user = User.find(params[:user_id])
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else 
      render 'new'
    end
  end

  def update
    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html { redirect_to @post, notice: 'Post was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end


  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:photo, :caption, :tags, :likes, :picture)
    end
end
