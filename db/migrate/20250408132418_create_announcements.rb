class CreateAnnouncements < ActiveRecord::Migration[7.2]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :description
      t.datetime :published_at

      t.timestamps
    end
  end
end
