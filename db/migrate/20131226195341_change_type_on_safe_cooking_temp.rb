class ChangeTypeOnSafeCookingTemp < ActiveRecord::Migration
  def change
    remove_column :safe_cooking_temps, :type
    add_column :safe_cooking_temps, :meat_type, :string

  end
end
