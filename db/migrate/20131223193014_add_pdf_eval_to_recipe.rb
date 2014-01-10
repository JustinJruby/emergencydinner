class AddPdfEvalToRecipe < ActiveRecord::Migration
  def change

    add_column :recipes, :pdf_eval, :string
  end
end
