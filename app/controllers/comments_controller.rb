class CommentsController < ApplicationController
  before_action :find_tweet

  def new
  	@comment = Comment.new
  end

  def create
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

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
