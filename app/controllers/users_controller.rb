class UsersController < ApplicationController
  def index
  end

  def follow
  	new_follow = current_user.followed_users.new(followee_id: params[:id])
  	if new_follow.save
  		flash[:alert] = 'followed successfully'
  	else
      flash[:alert] = 'Sorry! couldnt follow'
  	end
    redirect_to root_path
  end

  def unfollow
    follow = current_user.followed_users.find_by(followee_id: params[:id])
    if follow.destroy
      flash[:alert] = 'Successfullyy unfollowed'
    else
      flash[:alert] = 'Sorry! couldnt unfollow'
    end
    redirect_to root_path
  end
end
