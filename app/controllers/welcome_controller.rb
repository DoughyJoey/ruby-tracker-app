class WelcomeController < ApplicationController
  # way of bypassing the authentication
  # skip_before_action :authenticate_user!, only: [:index]
  def index
  end
end
