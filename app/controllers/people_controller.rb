class PeopleController < ActionController::Base
  def edit
    @person = Person.find(params[:id])
    @tags = Tag.all
  end

  def update
    @person = Person.find(params[:id])

    params[:tag_ids].each do |tag_id|
      @person.add_tag(tag_id)
    end

    redirect_to edit_person_path(@person), notice: 'Person manipulated.'
  end

end