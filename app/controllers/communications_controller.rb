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

    #not working/adapted yet

    params["unexisting_people"].values.each do |hash|
      if (hash["first_name"].present? or hash["last_name"].present?)
        Person.create({first_name: hash["first_name"], last_name: hash["last_name"]})
      end
    end

    redirect_to new_communication_path, notice: "Save attempted."
  end

end