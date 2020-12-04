class RetweetsController < ApplicationController
before_action :find_tweet, only: [:create, :destroy]
  
  def index
  end

  def create
    if already_retweeted
      flash[:alert] = "Oops! you have already retweeted this tweet"
      redirect_to tweets_path
    else 
      @retweet = @tweet.retweets.create(user_id: current_user.id)
      flash[:alert] = "retweeted this tweet"
      respond_to do |format|
      format.html
      format.js{}
    end
    end
  end
  
  private
  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def already_retweeted
    Retweet.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
  end

  def retweet_params
  	params.require(:retweet).permit(:tweet_id, :user_id)
  end
end
