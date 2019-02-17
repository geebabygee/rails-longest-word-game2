require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }.take(10).shuffle!
  end

  def score
    @letters = params[:letters].split # The letters are passed in a hidden field in the form,
    #when we click submit we don't want new letters, we want the letters given
    @word = (params[:word]).upcase
    @included = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    json = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    @english_word = json['found']
    if @english_word && @included
      @score = session[:score]
      if @score.nil?
        @score = @word.length
      end
      @score += @word.length
    else
      @score = 0
    end
  end
end


# # in the view - we want to display the letters, take the word input from the user and post the score back to the viewer
# # in score
