class CreateContents < ActiveRecord::Migration[7.2]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.references :fanclub, null: false, foreign_key: true

      t.timestamps
    end
  end
end
