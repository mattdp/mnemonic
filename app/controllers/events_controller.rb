class EventsController < ApplicationController

  def index
    @manual_events = Event.where(event_type: "manually_created").reverse
  end

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
    @event.event_type = "manually_created"
    @event.save

    tag = @event.make_event_tag

    verb_id = Verb.find_by_name("saw at").id

    params["unexisting_people"].values.each do |hash|
      Person.create_event_related_person!(hash,@event,verb_id,tag.id)
    end

    #NOT DRY - very similar logic in update
    if params[:people].present?
      params[:people].each do |person_id|
        Tagging.create_without_duplicates(person_id,verb_id,tag.id)
        Communication.create_event_related_communication!(@event,person_id,"Saw at event '#{@event.content}'")
      end
    end

    redirect_to edit_event_path(@event), notice: "Event created."
  end

  def edit
    @person_attributes = Person.overview_attributes
    @event = Event.find(params[:id])
    @tag = @event.tag
    @tags = Tag.all
    @addable_people = Person.all
    if @tag.present?
      @people = Person.joins(:taggings).where(taggings: {tag_id: @tag.id})
    end
  end

  def update
    event = Event.find(params[:id])
    event.content = params["event"]["content"]
    event.notes = params["event"]["notes"]
    event.happening_date = Date.new(params["event"]["happening_date(1i)"].to_i,params["event"]["happening_date(2i)"].to_i,params["event"]["happening_date(3i)"].to_i)
    event.save

    if params["previously_attached_people"].present?
      params["previously_attached_people"].each do |id, hash|
        person = Person.find(id)
        #subverting strong params in an insecure way
        hash[:person].each do |k,v|
          person.send("#{k}=",v)
        end
        person.save
        person.controller_save(hash)
      end
    end

    verb_id = Verb.find_by_name("saw at").id
    tag = Tag.find_by_event_id(event.id)

    #NOT DRY - very similar logic in create
    if params[:people].present?
      params[:people].each do |person_id|
        Tagging.create_without_duplicates(person_id,verb_id,tag.id)
        Communication.create_event_related_communication!(event,person_id,"Saw at event '#{event.content}'")
      end
    end

    params["unexisting_people"].values.each do |hash|
      Person.create_event_related_person!(hash,event,verb_id,tag.id)
    end

    redirect_to edit_event_path(event), notice: "Save attempted."
  end

  private

    def person_params
      params.require(:person).permit(Person.general_attributes)
    end

end