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

  def new
    @event = Event.new
  end

  def create
    @event = Event.new
    @event.content = params[:content]
    @event.save

    nfl = Tag.proper_name_for_link(params[:content])

    tag = Tag.find_by_name(params[:content])
    tag = Tag.find_by_name_for_link(nfl) if tag.nil?
    if tag.present?
      tag.event_id = @event.id
      tag.save
    else
      tag = Tag.create({name: params[:content], 
        name_for_link: nfl,
        event_id: @event.id
        })
    end

    redirect_to edit_event_path(@event), notice: "Event created."
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
  end

end