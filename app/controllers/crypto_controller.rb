class CryptoController < ApplicationController

    def news
        require 'net/http'
        require 'json'

        # grabs news data
        @url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @news = JSON.parse(@response)
    end

    def price
        require 'net/http'
        require 'json'

        @prices_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=XRP&tsyms=USD'
        @prices_uri = URI(@prices_url)
        @prices_response = Net::HTTP.get(@prices_uri)
        @prices = JSON.parse(@prices_response)

    end
end