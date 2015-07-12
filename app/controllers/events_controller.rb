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
    @people = Person.all
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

    verb = Verb.find_by_name("saw at")

    params["new_people"].values.each do |hash|
      if (hash["first_name"].present? or hash["last_name"].present?)
        person = Person.create({first_name: hash["first_name"], last_name: hash["last_name"]})
        Tagging.create_without_duplicates(person.id,verb.id,tag.id)
      end
    end

    if params[:people].present?
      params[:people].each do |person_id|
        Tagging.create_without_duplicates(person_id,verb.id,tag.id)
      end
    end

    redirect_to edit_event_path(@event), notice: "Event created."
  end

  def edit
    @event = Event.find(params[:id])
    @tag = @event.tag
    if @tag.present?
      @people = Person.joins(:taggings).where(taggings: {tag_id: @tag.id})
    end
  end

  def update
  end

end