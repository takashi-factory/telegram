class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :edit, :update, :destroy ]

  def index
    @posts = Post.find_newest_post(params[:page]).
      with_user_and_comment
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params) # ストロングパラメータ
    if @post.save # saveをしてデータベースに保存
      redirect_to @post, notice: '投稿を保存しました!' # showページにリダイレクト
    else
      render :new
    end
  end

  def show
    @post = Post.includes(comments: [user: [avatar_attachment: :blob]], user: [avatar_attachment: :blob]).find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿を更新したぞ.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しますた."
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
