class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :link
      t.string :time
      t.string :ingredient
      t.boolean :pantry

      t.timestamps
    end
  end
end
