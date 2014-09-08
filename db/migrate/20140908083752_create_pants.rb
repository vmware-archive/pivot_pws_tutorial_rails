class CreatePants < ActiveRecord::Migration
  def change
    create_table :pants do |t|

      t.timestamps
    end
  end
end
