class EventsController < ActionController::Base

  def dismiss
    @event = Event.find(params[:id])
    @event.dismiss

    redirect_to root_path, notice: "Event dismissed."
  end
  
end