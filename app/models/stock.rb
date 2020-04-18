class Stock < ApplicationRecord
    # create relationship between stocks and users
    has_many :user_stocks
    has_many :users, through: :user_stocks
  
    # ensures we have a valid name and ticker when saving to the database
    # didn't use price because it will change
    validates :name, :ticker, presence: true

    # https://github.com/dblock/iex-ruby-client
    # enables us to lookup IEX stocks
    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            secret_token: Rails.application.credentials.iex_client[:sandbox_api_secret_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
        # returns a new custom stock object
        begin
            new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
        # if stock object was not found
        rescue => exception
            return nil
        end
    end

    # checks if the stock already exists in the database
    def self.check_db(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
end
