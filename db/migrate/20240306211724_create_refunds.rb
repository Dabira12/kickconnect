class CreateRefunds < ActiveRecord::Migration[7.0]
  def change
    create_table :refunds do |t|
      t.text :description
      t.boolean :resolved

      t.timestamps
    end
  end
end
