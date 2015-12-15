class PeopleController < ApplicationController

  def edit
    @person = Person.find(params[:id])
    @tags = Tag.all
    @feed = @person.feed
  end

  def update
    @person = Person.find(params[:id])

    params[:tags].each do |tag_id|
      @person.add_tag(tag_id.to_i)
    end

    redirect_to edit_person_path(@person), notice: 'Person manipulated.'
  end

  def prospectives
    @people = Person.where(prospective: true).take(5)
    @all_tags = Tag.all
    @overview_attributes = Person.overview_attributes
  end

  def prospectives_submission

    if params["previously_attached_people"].present?
      params["previously_attached_people"].each do |id, hash|
        person = Person.find(id)
        if hash["select_action"] == "no_longer_prospective"
          person.controller_save(hash)
        elsif hash["select_action"] == "attach_to_existing_person"
          surviving_person = Person.find(hash["attach_to_id"])
          surviving_person.devour(person)
        elsif hash["select_action"] == "block_future_email"
          ContactMethod.create(filter: "email", 
            info: person.email,
            ignore: true)
          person.destroy
        end
      end
    end

    redirect_to people_prospectives_path, notice: 'Saving attempted.'
  end

  def generate_names
    Person.generate_all_blank_names

    redirect_to root_path, notice: 'Name generation attempted.'
  end

  def table
    @people = Person.table_order
    @grey_out = [[4,1],[4,2],[4,3],[3,1],[3,2],[2,1]]
    @most_often = [[3,4]]
    @second_most_often = [[4,4]]
    @third_most_often = [[2,4],[1,4],[3,3]]
  end

end