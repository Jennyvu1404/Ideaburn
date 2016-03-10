class Api::LocationController < ApplicationController
  def states
    render json: CS.get(params[:country]).to_json
  end

  def cities
    render json: CS.cities(params[:state], params[:country]).to_json
  end
end
