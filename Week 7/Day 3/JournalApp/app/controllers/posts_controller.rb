class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  # def new
  #   @post = Post.new()
  #   render json: @post
  # end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  # def edit
  #   @post = Post.find(params[:id])
  #   if @post.update_attributes(post_params)
  # end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      @posts = Post.all
      render json: @posts
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post
      render json: @post
    else
      render json: @post.errors.full_messages, status: 404
    end
  end

  def index
    @posts = Post.all
    render json: @posts
  end

  private
  def post_params
    params.require(:post).permit(:body, :title)
  end

end
