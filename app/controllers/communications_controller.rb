class CommunicationsController < ApplicationController

  def new
    @people = Person.names_for_search
  end

  def create

    if params["new_people"].present?
      params["new_people"].each do |index_number,information|
        if (information["medium"].present? and information["contents"].present?)
          id = information["name_info"].match(/\[(\d*)\]/)[1].to_i
          communication = Communication.new(person_id: id,
            medium: information["medium"],
            contents: information["contents"],
          )
          #when is a really dumb variable name
          communication.when = Date.new(information["when"]["when(1i)"].to_i,information["when"]["when(2i)"].to_i,information["when"]["when(3i)"].to_i)
          communication.save
        end
      end
    end

    redirect_to new_communication_path, notice: "Save attempted."
  end

end