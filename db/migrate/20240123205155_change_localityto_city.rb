class ChangeLocalitytoCity < ActiveRecord::Migration[7.0]
 
    def change
      rename_column :addresses, :locality, :city
    end

end
