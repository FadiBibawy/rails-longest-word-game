class GamesController < ApplicationController

  def new
    @letters = (0...10).map { rand(65..90).chr }

  end

  # def score

  # end
end
