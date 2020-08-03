class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end

    change_table :users do |t|
      t.string :email
    end
  end
end
