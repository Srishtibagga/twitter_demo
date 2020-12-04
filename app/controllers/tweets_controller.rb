class TweetsController < ApplicationController
  before_action :find_tweet, except: [:new, :create, :index, :my_tweets]
  
  def index
    @tweets = Tweet.where(:user_id => current_user.followees).or(Tweet.where(user_id: current_user.id))#.or(Reweet.where(user_id: current_user.followees))
    #@tweets = Tweet.joins(user: :following_users).where(users: {follows: {follower_id: current_user.id}}).distinct
  	#@tweets = Tweet.all
  end

  def my_tweets
    #debugger
    # @tweets = Tweet.joins(:retweets).where(user_id: current_user.id , retweets: {user_id: current_user.id})
    @tweets = Tweet.left_outer_joins(:retweets).where("tweets.user_id=? or retweets.user_id=?", current_user.id, current_user.id).distinct
    #@tweets =Tweet.find_by_sql("SELECT * FROM tweets INNER JOIN retweets ON retweets.tweet_id = tweets.id WHERE tweets.user_id = 13 OR retweets.user_id = 13")
    #@tweets = Tweet.joins("INNER JOIN retweets ON tweets.id = retweets.user_id").where(user_id: current_user.id)
    #@tweets =  current_user.tweets
  end

  def new
  	@tweet = Tweet.new
    1.times { @tweet.images.build }
  end

  def create
  	#debugger
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
    	flash[:alert] = 'Here is your tweet'
    	redirect_to tweet_path(@tweet)
    else
    	flash[:alert] = "Sorry! unable to upload your tweet "
      #render 'new'
      redirect_to new_tweet_path
    end
  end

  def show
  end

  def edit
  end

  def update
  	if @tweet.update(tweet_params)
  		flash[:alert] = 'updated'
  		redirect_to tweet_path(@tweet)
  	else
  		render 'edit'
  	end
  end
  
  def destroy 
    if @tweet.destroy
    	flash[:alert] = "Successfully! tweet deleted"
    	redirect_to new_tweet_path
    else
    	flash[:alert] = "Sorry! Enable to delete your tweet"
    	redirect_to 
    end
  end
  private

  def find_tweet
    @tweet = current_user.tweets.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content, images_attributes: [:id, :image, :imageable_type, :imageable_id, :_destroy ])
  end

end
