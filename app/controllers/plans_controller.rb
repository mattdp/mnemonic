class PlansController < ApplicationController

  def index
    @plans = Plan.undismissed.sort
    @deed_id = params[:deed_id]
  end

  def show
    @plan = Plan.find(params[:id])
    @display_flags = Plan.display_flags

    plans = Plan.undismissed
    @random_plan_id = plans[Random.rand(0...plans.length)].id
  end

  def wip
  end

end