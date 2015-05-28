class EventsController < ApplicationController

  def dismiss
    @event = Event.find(params[:id])
    @event.dismiss(params[:dismissed_reason])

    redirect_to root_path, notice: "Event dismissed."
  end

  def snooze
    @event = Event.find(params[:id])
    @event.snooze(params[:snooze_days])

    redirect_to root_path, notice: "Event snoozed #{params[:snooze_days]} days."
  end
  
  def birthday_generator
    Event.birthday_generator

    redirect_to root_path, notice: "Birthdays generated."
  end

end