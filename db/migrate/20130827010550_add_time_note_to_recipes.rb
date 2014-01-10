class AddTimeNoteToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :time_note, :string
    remove_column :recipes, :time
    add_column :recipes, :time, :integer
  end
end
