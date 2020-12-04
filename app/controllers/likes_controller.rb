class LikesController < ApplicationController
  before_action :find_tweet, only: [:create, :destroy]
  
  def index
  end

  def create
  	#debugger
    @like = @tweet.likes.create(user_id: current_user.id)
    #redirect_to tweets_path
    respond_to do |format|
      format.html
      format.js{}
    end
  end

  def show
  end

  def destroy
    @like = @tweet.likes.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.html
      format.js{}
    end
  end
  
  private
  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def likes_params
  	params.require(:like).permit(:tweet_id, :user_id)
  end
end
