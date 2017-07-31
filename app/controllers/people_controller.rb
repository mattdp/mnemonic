class PeopleController < ApplicationController

  def edit
    @person = Person.find(params[:id])

    @tags = Tag.all
    @feed = @person.feed
    @prefix = "modified"
  end

  def update
    @person = Person.find(params[:id])
    @person.prospective = false
    @person.update(person_params)

    @person.controller_save(params["modified"])
    redirect_to edit_person_path(@person), notice: 'Person manipulated.'
  end

  def prospectives
    @people = Person.where(prospective: true).take(5)
    @all_people = Person.all
    @all_tags = Tag.all
    @overview_attributes = Person.overview_attributes
  end

  def navigate_to_person
    redirect_to edit_person_path(params[:navigate_to_person])
  end

  def prospectives_submission

    if params["previously_attached_people"].present?
      params["previously_attached_people"].each do |id, hash|
        person = Person.find(id)
        if hash["select_action"] == "block_future_email"
          ContactMethod.create(filter: "email", 
            info: person.contact_methods[0].info,
            ignore: true)
          person.destroy
        else
          #subverting strong params in an insecure way
          person.prospective = false
          hash[:person].each do |k,v|
            person.send("#{k}=",v)
          end
          person.save
          person.controller_save(hash)
          if hash["select_action"] == "attach_to_existing_person"
            surviving_person = Person.find(hash["attach_to_id"][0])
            surviving_person.devour(person)
          end
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
    @most_often = [[4,4]]
    @second_most_often = [[3,4]]
    @third_most_often = [[3,3],[2,4],[1,4]]
    @fourth_most_often = [[2,3]]
  end

  private

    def person_params
      params.require(:person).permit(Person.general_attributes)
    end

end