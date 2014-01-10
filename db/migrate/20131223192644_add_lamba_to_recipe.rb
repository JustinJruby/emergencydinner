class AddLambaToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :lamba, :string
  end
end
