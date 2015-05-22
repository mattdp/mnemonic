class DisplaysController < ApplicationController
  def index
    @events = Event.events_by_display_category
  end
end
