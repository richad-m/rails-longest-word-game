require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @grid = []
    10.times { @grid << alphabet.sample}
  end

  def in_list(word, grid)
    list= word.chars
    # raise
    result = word.chars.all? {|letter| list.count(letter) <= grid.count(letter.upcase)}
  end

  def score
    @attempt = params[:answer]
    @grid = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    word_serialized = open(url).read
    @word = JSON.parse(word_serialized)
    # puts @grid
    if in_list(@attempt, @grid)
      if @word["found"] == true
        @answer = "BRAVO!"
      else
        @answer = "This word does not exist"
      end
    else
      @answer = "#{@attempt} cannot be built out of #{@grid.split.join(',')}"
    end
    # raise
  end
end
