class CommentsController < ApplicationController
  def new
  	@comment = Comment.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.create(comment_params)
    respond_to do |format|
    format.html
    format.js{}
  end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
