class StocksController < ApplicationController

  # SEARCH METHOD
    def search
      # if stock is present, render the result
      if params[:stock].present?
        @stock = Stock.new_lookup(params[:stock])
        if @stock
          respond_to do |format|
            # renders using js - enables us to us AJAX
            format.js { render partial: 'users/result' }
          end
        else
          # if symbol is incorrect
          respond_to do |format|
            flash.now[:alert] = "Please enter a valid symbol to search"
            # renders using js - enables us to us AJAX
            format.js { render partial: 'users/result' }
          end
        end    
      else
        # if no symbol was submitted
        respond_to do |format|
          flash.now[:alert] = "Please enter a symbol to search"
          # renders using js - enables us to us AJAX
          format.js { render partial: 'users/result' }
        end
      end
    end
  end