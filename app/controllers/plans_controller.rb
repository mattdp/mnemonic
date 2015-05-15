class PlansController < ApplicationController

  def index
    @plans = Plan.undismissed.sort
    @deed_id = params[:deed_id]
  end

  def wip
  end

end