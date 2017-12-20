class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :denetim]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post
  before_action :denetim, only: [:edit,:destroy]
  
  def denetim
    unless @comments.user_id==current_user.id
      redirect_to post_url(params[:post_id]),notice:"Bu Kayıt Üzerinde İşlem Yapabilmek İçin Yetkiniz Bulunmamaktadır."
    end
  end
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = @post.comments.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @post.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user= current_user
  
    respond_to do |format|
      if @comment.save
        format.js
        format.html { redirect_to post_url(params[:post_id]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comments = Comment.find(params[:id])
    @comments.bdy=comment_params[:bdy]
    @comments.save
    respond_to do |format|
      if @comments.save
        format.html { redirect_to post_url(params[:post_id]), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    Comment.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to post_url(params[:post_id]), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post=Post.find(params[:post_id])
      #@comment = @post.comments.find(params[:id])
    end

    def set_comment
      @comments = Comment.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:bdy)
    end
end
