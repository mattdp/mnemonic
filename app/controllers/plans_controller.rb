class PlansController < ActionController::Base

  def index
    @plans = Plan.undismissed.sort
  end

  def wip
  end

end