class CreateJournals < ActiveRecord::Migration[8.0]
  def change
    create_table :journals do |t|
      t.string :title
      t.text :content
      t.string :author
      t.datetime :published_at

      t.timestamps
    end
  end
end
