class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.jsonb :data

      t.timestamps
    end
  end
end
