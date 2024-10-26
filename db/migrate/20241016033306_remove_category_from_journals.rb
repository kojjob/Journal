class RemoveCategoryFromJournals < ActiveRecord::Migration[8.0]
  def change
    remove_column :journals, :category, :string
  end
end
