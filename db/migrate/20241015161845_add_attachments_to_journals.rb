class AddAttachmentsToJournals < ActiveRecord::Migration[8.0]
  def change
    add_column :journals, :images, :text
    add_column :journals, :videos, :text
  end
end
