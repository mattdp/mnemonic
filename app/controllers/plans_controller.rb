class PlansController < ActionController::Base

  def index
    @plans = Plan.undismissed.sort
  end

end