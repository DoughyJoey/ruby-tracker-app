class UsersController < ApplicationController

  # sets user to the current user
  # gets tracked stocks for the current user
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  # gets friends of the current user
  def my_friends
    @friends = current_user.friends
  end

  # show a users (friends) profile and their tracked stocks
  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    # if the friend is present
    if params[:friend].present?
      # runs the User.search method from the user.rb
      @friends = User.search(params[:friend])
      # excludes the users details
      @friends = current_user.except_current_user(@friends)
      if @friends
        # renders the friends results
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        # renders message if user doesn't exist
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/friend_result' }
        end
      end    
    else
      # render message if the search is empty
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end
end