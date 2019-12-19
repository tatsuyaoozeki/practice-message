class CommentsController < ApplicationController
  #コメントを投稿・保存するためのアクションです
  def create
    #blogパラメータの値から探し出し、Blogに基づくcommentsとしてbuildします
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    #クライアントの要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@blog), notice: '投稿できませんでした....' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:blog_id, :content)
  end
end
