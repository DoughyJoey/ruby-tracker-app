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

        @prices_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,XRP,USDT,BCH,BSV,LTC,EOS,BNB,XTZ&tsyms=USD'
        @prices_uri = URI(@prices_url)
        @prices_response = Net::HTTP.get(@prices_uri)
        @prices = JSON.parse(@prices_response)

    end

    def result

    end
end