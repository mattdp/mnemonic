class EventsController < ApplicationController

  def dismiss
    @event = Event.find(params[:id])
    @event.dismiss(params[:dismissed_reason])
    if (params[:dismissed_reason] == "success" or params[:dismissed_reason] == "tried_openly")
      Communication.create_event_related_communication!(@event,@event.person_id,"#{params[:dismissed_reason]} for '#{@event.content}'")
    end

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

    verb_id = Verb.find_by_name("saw at").id

    params["unexisting_people"].values.each do |hash|
      Person.create_event_related_person!(hash,@event,verb_id,tag.id)
    end

    if params[:people].present?
      params[:people].each do |person_id|
        Tagging.create_without_duplicates(person_id,verb_id,tag.id)
        Communication.create_event_related_communication!(@event,person_id,"Saw at event '#{@event.content}'")
      end
    end

    redirect_to edit_event_path(@event), notice: "Event created."
  end

  def edit
    @person_attributes = person_attributes
    @event = Event.find(params[:id])
    @tag = @event.tag
    if @tag.present?
      @people = Person.joins(:taggings).where(taggings: {tag_id: @tag.id})
    end
  end

  def update
    person_attributes = person_attributes
    event = Event.find(params[:id])
    event.content = params["event"]["content"]
    event.notes = params["event"]["notes"]
    event.happening_date = Date.new(params["event"]["happening_date(1i)"].to_i,params["event"]["happening_date(2i)"].to_i,params["event"]["happening_date(3i)"].to_i)
    event.save

    params["people"].each do |id, hash|
      if hash["communication_id"].present?
        communication = Communication.find(hash["communication_id"])
        communication.contents = hash["communication_contents"]
        communication.save
      end
      hash.except!("communication_id","communication_contents")
      person = Person.find(id)
      person.assign_attributes(hash)
      person.save
    end

    redirect_to edit_event_path(event), notice: "Save attempted."
  end

  private

    def person_attributes
      [:first_name, :last_name, :email, :phone, :relationship_current, :relationship_possible] 
    end

end