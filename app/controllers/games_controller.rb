require 'open-uri'
require 'json'

class GamesController < ApplicationController


  def new
    @letters = ('a'..'z').to_a.sample(10).join('')
  end

  def valid?(attempt, grid)
    attempt.chars.each do |char|
      counter = attempt.count(char)
      counter_grid = grid.count(char.downcase)
      return false if counter > counter_grid
    end
    return true
  end

  def score
    open_uri_hash = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)
    @letters = params[:letters].chars
    @word = params[:word]

    if valid?(@word, @letters)
      if open_uri_hash["found"]
        @result = "Congratulations! #{params[:word]} is a valid English word!"
      else
        @result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
      end

    else
      @result = "Lost"
    end
  end
end
