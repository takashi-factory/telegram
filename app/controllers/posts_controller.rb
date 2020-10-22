class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :show, :edit, :update, :destroyn ]

  def index
    @post = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)#ストロングパラメータ
    if @post.save # saveをしてデータベースに保存
      redirect_to @post, notice: '投稿を保存しました!' # showページにリダイレクト
    else
      render :new
    end
  end

  def show
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
