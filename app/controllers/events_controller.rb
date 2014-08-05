class EventsController < ActionController::Base

  def dismiss
    @event = Event.find(params[:id])
    @event.dismiss

    binding.pry

    redirect_to root_path, notice: "Event dismissed."
  end
  
end