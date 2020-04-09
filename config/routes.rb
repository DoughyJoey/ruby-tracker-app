Rails.application.routes.draw do
  # enables users to track and remove stocks
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root 'welcome#index'
  # get my_portfolio, send it to users which has a my_portfolio action
  get 'my_portfolio', to: 'users#my_portfolio'
  # get search_stock, send it to stocks which has a search action
  get 'search_stock', to: 'stocks#search'
  # get my_friends, send it to users which has a friends action
  get 'my_friends', to: 'users#my_friends'
  # get search_friend, send it to users which has a search action
  get 'search_friend', to: 'users#search'
  # allows us to follow and remove friends
  resources :friendships, only: [:create, :destroy]
  # allows us to view a users profile
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
