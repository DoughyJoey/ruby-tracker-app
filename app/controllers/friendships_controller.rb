class FriendshipsController < ApplicationController

  def create
    # find the friend
    friend = User.find(params[:friend])
    # creates the friendship
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following friend"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to my_friends_path
  end

  def destroy
    # finds the friend
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    # destroys the row in the table
    friendship.destroy
    # notify the user
    flash[:notice] = "Stopped following"
    redirect_to my_friends_path
  end
end
