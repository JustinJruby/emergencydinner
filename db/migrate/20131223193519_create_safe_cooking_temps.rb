class CreateSafeCookingTemps < ActiveRecord::Migration
  def change
    create_table :safe_cooking_temps do |t|
      t.string :group
      t.string :type
      t.string :temp
      t.string :note

      t.timestamps
    end
  end
end
