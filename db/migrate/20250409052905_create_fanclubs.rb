class CreateFanclubs < ActiveRecord::Migration[7.2]
  def change
    create_table :fanclubs do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
