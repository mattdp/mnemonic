class DisplaysController < ApplicationController
  def index
    @time_based_events = Event.get_current_happening
    @wants_and_has = Event.get_displayable("wants").concat(Event.get_displayable("has"))
    @recent_taggings = Tagging.last(5).reverse
  end
end
