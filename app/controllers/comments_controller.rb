class CommentsController < ApplicationController
  before_action :find_tweet

  def new
  	@comment = Comment.new
  end

  def create
    #debugger
    @comment = current_user.comments.create(comment_params)
    # @comment = @tweet.comments.create(content: comment_params[:content], user_id: current_user.id)
    respond_to do |format|
      format.html
      format.js{}
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :tweet_id)
  end

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
 