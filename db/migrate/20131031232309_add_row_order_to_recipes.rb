class AddRowOrderToRecipes < ActiveRecord::Migration
  def change
     add_column :recipes, :row_order, :integer
     add_column :recipes, :steps, :text
     change_column :recipes, :ingredient, :text
  end
end
