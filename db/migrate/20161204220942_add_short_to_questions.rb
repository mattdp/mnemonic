class AddShortToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :short, :string
  end
end
