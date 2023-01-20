require 'open-uri'
require 'json'
# require 'pry'

class GamesController < ApplicationController
  def new
    $letters = (0...10).map { rand(65..90).chr }
    $start_time = Time.now
  end

  def score
    @input = params[:answer].upcase
    end_time = Time.now
    @duration = (end_time - $start_time).round(3)
    # in_grid = true
    @message = "Good Job!"
    @message = "You didn't type anything!" if @input == ''

    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    check_object = JSON.parse(URI.open(url).read)
    if check_object["found"] == false
      @message = "Your word is not an english word!"
    else
      @input.split('').each do |letter|
        unless $letters.include? letter
          @message = "you typed a letter out of the grid"
          # in_grid = false
        end
        index = $letters.index letter
        $letters.delete_at index unless index.nil?
      end
    end
    if @message == "Good Job!"
      @score = (@input.length * 100 / (@duration).to_f).round(3)
    else
      @score = 0
    end

  end
end
