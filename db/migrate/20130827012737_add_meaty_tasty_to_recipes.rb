class AddMeatyTastyToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :meaty, :boolean
    add_column :recipes, :tasty, :boolean
  end
end
