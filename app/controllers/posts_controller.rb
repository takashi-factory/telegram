class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)#ストロングパラメータ
    @post.save # saveをしてデータベースに保存
    redirect_to @post, notice: '投稿を保存しますた' # showページにリダイレクト
  end

  def show
    @post = Post.find(params[:id])
  end


  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
