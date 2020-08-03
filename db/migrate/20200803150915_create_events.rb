class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      
      t.timestamps
    end

    change_table :events do |t|
      t.datetime :time
    end
  end
end
