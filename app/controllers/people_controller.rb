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