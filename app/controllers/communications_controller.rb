class CommunicationsController < ApplicationController

  def new
    @people = Person.names_for_search
  end

  def create

    if params["new_people"].present?
      params["new_people"].each do |index_number,information|
        if (information["medium"].present? and information["contents"].present?)
          id = information["name_info"].match(/\[(\d*)\]/)[1].to_i
          Communication.create(person_id: id,
            medium: information["medium"],
            contents: information["contents"]
          )
        end
      end
    end

    redirect_to new_communication_path, notice: "Save attempted."
  end

end