require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }.shuffle!
  end

  def score
    @letters = params[:letters].split # The letters are passed in a hidden field in the form,
    #when we click submit we don't want new letters, we want the letters given
    @word = (params[:word]).upcase
    @included = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    json = JSON.parse(response)
    @english_word = json['found']
    if @english_word && @included
      if session[:score].nil?
        session[:score] = @word.length
      end
      session[:score] += @word.length
      @score = session[:score]
    else
      @score = 0
    end

  end


end
