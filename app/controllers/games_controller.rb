require 'httparty'
require 'json'

class GamesController < ApplicationController
  def new
    generate_grid
  end

  def score
    generate_output
  end

  private

  def generate_grid
    size = rand(8..12)
    @letters = []
    size.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def in_the_grid?(attempt, grid)
    p "params: #{attempt.scan(/\w/)}"
    p "grid: #{grid.scan(/\w/)}"
    (attempt.scan(/\w/) - grid.scan(/\w/)).empty?
  end

  def english_word?(attempt)
    response = HTTParty.get("https://wagon-dictionary.herokuapp.com/#{attempt}")
    response['found']
  end

  def generate_output
    in_the_grid?(params[:score], params[:letter_grid])
    if english_word?(params[:score]) && in_the_grid?(params[:score], params[:letter_grid])
      @solution = 'Great, that worked'
    else @solution = 'nüscht'
    end
  end
end
