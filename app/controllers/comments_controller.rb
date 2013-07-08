class CommentsController < ApplicationController
before_filter :authenticate_user!

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    if @comment.user.id == current_user
      current_user = @comment.user
    else
      redirect_to :back, alert: "You can only edit comments that you created."
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.create(params[:comment])
    redirect_to :back
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user.id == current_user
      @comment.destroy
      redirect_to root_path
    else
      redirect_to :back, alert: "You can only delete comments that you created."
    end
  end
end
