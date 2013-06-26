class PostsController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :post_tag, :name, :class_name => 'post_tag'
  # GET /posts
  # GET /posts.json
  def index
    Post.update_points
    if params[:search]
      @posts = Post.search(params[:search])
    elsif params[:post_tag]
      @posts = Post.tagged_with(params[:post_tag]).order('points DESC')
    elsif params[:citysearch]
      @posts = Post.citysearch(params[:citysearch]) 
    else
      @posts = Post.order('points DESC')
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if @post.user.id == current_user
      current_user = @post.user
    else
      redirect_to :back, alert: "You can only edit posts that you created."
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if @post.user.id == current_user
      @post.destroy
      redirect_to root_path
    else
      redirect_to :back, alert: "You can only delete posts that you created."
    end
  end
end
