class DisplaysController < ActionController::Base
  def index
    @birthdays = Event.get_displayable("birthday")
    @wants_and_has = Event.get_displayable("wants").concat(Event.get_displayable("has"))
    @recent_taggings = Tagging.last(5).reverse
  end
end
