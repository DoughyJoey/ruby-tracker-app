class UserStocksController < ApplicationController

  def create
    # check if the stock already exists
    stock = Stock.check_db(params[:ticker])
    # if the stock doesn't exist
    # lookup the stock and save it to the database
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end  
    # add stock to portfolio, notify user, and redirect to portfolio page
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end


  def destroy
    # finds the stock
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    # removes the stock
    user_stock.destroy
    # notify the user
    flash[:notice] = "#{stock.ticker} was successfully removed from portfolio"
    redirect_to my_portfolio_path
  end

end