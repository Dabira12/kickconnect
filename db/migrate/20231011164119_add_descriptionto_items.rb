class AddDescriptiontoItems < ActiveRecord::Migration[7.0]
  def change
    add_column :Items, :description, :text
  end
end
