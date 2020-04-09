class User < ApplicationRecord
  # create relationship between users and stocks
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # create relationship between users
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # checks if a user is already tracking a stock
  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?    
  end
  
  # checks if a users stock count is less than 10
  def under_stock_limit?
    stocks.count < 10
  end

  # checks if a user can track a stock
  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  # returns first name and last name or anonymous
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end


  def self.search(param)
    # strips empty spaces
    param.strip!
    # returns only unique user values
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    # returns nil if no user found
    # else, returns the user
    return nil unless to_send_back
    to_send_back
  end

  # checks if the first name matches the param
  def self.first_name_matches(param)
    matches('first_name', param)
  end

  # checks if the last name matches the param
  def self.last_name_matches(param)
    matches('last_name', param)
  end

  # checks if the email matches the param
  def self.email_matches(param)
    matches('email', param)
  end

  # checks if anything matches the param
  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  # excludes current user from the search results
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  # checks if a user is not already friends with another user
  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end
end
